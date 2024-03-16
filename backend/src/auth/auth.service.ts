import {
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

/**
 * This is the service regarding user auth.
 *
 * @public
 */
@Injectable()
export class AuthService {
  /**
   * This function creates an AuthService and takes all required services for dependency injection.
   *
   * @param prismaService The service to access prisma.
   * @param config The service to access .env files
   * @param jwtService The service to sign JWTs.
   *
   * @constructor
   *
   */
  constructor(
    private readonly prismaService: PrismaService,
    private readonly config: ConfigService,
    private readonly jwtService: JwtService,
  ) { }

  /**
   * With this function, the user can sign in and get a signed access token.
   *
   * @param {AuthDto} dto - The DTO that contains the user's auth details
   *
   * @returns {Promise<AccessTokenType>} - Promise with the signed access token
   *
   * @throws {ForbiddenException} - If the provided credentials are wrong
   * @throws {NotFoundException} - If the user was not found by mail
   */
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

  /**
   * With this function, the user can sign up and get a signed access token.
   *
   * @param {AuthDto} dto - The DTO that contains the user's auth details
   *
   * @returns {Promise<AccessTokenType>} - Promise with the signed access token
   *
   * @throws {ForbiddenException} - If the mail is already taken
   */
  async signup(dto: AuthDto): Promise<AccessTokenType> {
    // generate the password hash
    const hash: string = await argon.hash(dto.password);

    const user: User = await this.createUserOrThrow(dto.email, hash);

    return this.signToken(user.id, user.email);
  }

  /**
   * With this function, a user that has signed in with google gets his access_token.
   *
   * @param {string} mail - The mail of the google user
   *
   * @returns {Promise<AccessTokenType>} - Promise with the signed access token
   *
   * @throws {NotFoundException} - If the user was not found by mail
   */
  async googleSignIn(mail: string): Promise<AccessTokenType> {
    const user: User = await this.findUserOrThrow(mail);

    return this.signToken(user.id, user.email);
  }

  /**
   *
   * With this function, a user that has signed up with google gets his access token.
   *
   * @param {string} mail - The mail of the google user
   * @returns {Promise<AccessTokenType>} - Promise with the signed access token
   *
   * @throws {ForbiddenException} - If a user with the given mail already exists.
   */
  async googleSignup(mail: string): Promise<AccessTokenType> {
    const user: User = await this.createUserOrThrow(mail);

    return this.signToken(user.id, user.email);
  }

  /**
   *
   * This function creates a token and signs it.
   *
   * @param {string} userId - The id of the user to sign.
   * @param {string} email - The email that is written in the access token
   * @returns {Promise<AccessTokenType>} - The signed access_token
   */
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

  /**
   * This function searches the database for a user.
   *
   * @param {string} mail - The mail of the user to find
   * @returns {Promise<User>} - The found user
   *
   * @throws {NotFoundException} - If the user is not found
   */
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

  /**
   * This function creates a user in the database.
   * @param {string} mail - The mail of the user
   * @param {string} passwordhash - The hash of the password
   * @returns {Promise<User>} - The created user
   *
   * @throws {ForbiddenException} - If the credentials are already taken
   */
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
