import {
  ConflictException,
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { AuthDto } from './dto';
import { PrismaService } from 'nestjs-prisma';
import * as argon from 'argon2';
import { PrismaClientKnownRequestError } from '@prisma/client/runtime/library';
import { ConfigService } from '@nestjs/config';
import { JwtService } from '@nestjs/jwt';
import { User } from '@prisma/client';
import { AccessTokenType } from './types';

@Injectable()
export class AuthService {
  constructor(
    private readonly prismaService: PrismaService,
    private readonly config: ConfigService,
    private readonly jwtService: JwtService,
  ) {}

  async signin(dto: AuthDto): Promise<AccessTokenType> {
    const user: User = await this.findUserOrThrow(dto.email);

    // compare password
    const pwMatches: boolean = await argon.verify(
      user.passwordHash,
      dto.password,
    );
    // if password incorrect throw exception
    if (!pwMatches) throw new ForbiddenException('Credentials incorrect');
    return this.signToken(user.id, user.email);
  }

  async signup(dto: AuthDto): Promise<AccessTokenType> {
    // generate the password hash
    const hash: string = await argon.hash(dto.password);

    const user: User = await this.createUserOrThrow(dto.email, hash);

    return this.signToken(user.id, user.email);
  }

  async googleSignIn(mail: string): Promise<AccessTokenType> {
    const user: User = await this.findUserOrThrow(mail);

    return this.signToken(user.id, user.email);
  }

  async googleSignup(mail: string): Promise<AccessTokenType> {
    const user: User = await this.createUserOrThrow(mail);

    return this.signToken(user.id, user.email);
  }

  async signToken(userId: number, email: string): Promise<AccessTokenType> {
    const payload = {
      sub: userId,
      email,
    };

    const secret: string = this.config.get('JWT_SECRET');

    const token: string = await this.jwtService.signAsync(payload, {
      expiresIn: '15m',
      secret: secret,
    });

    return {
      access_token: token,
    };
  }

  private async findUserOrThrow(mail: string): Promise<User> {
    // find the user by email
    const user: User = await this.prismaService.user.findUnique({
      where: {
        email: mail,
      },
    });

    // if user does not exist throw exception
    if (!user) throw new NotFoundException('User not found');

    return user;
  }

  private async createUserOrThrow(
    mail: string,
    passwordhash?: string,
  ): Promise<User> {
    // save the new user in the db
    try {
      const user = await this.prismaService.user.create({
        data: {
          email: mail,
          passwordHash: passwordhash,
        },
      });

      return user;
    } catch (error) {
      if (error instanceof PrismaClientKnownRequestError) {
        if (error.code === 'P2002') {
          throw new ForbiddenException('Credentials taken');
        }
      }
      throw error;
    }
  }
}
