import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { PassportStrategy } from '@nestjs/passport';
import { User } from '@prisma/client';
import { PrismaService } from 'nestjs-prisma';
import { ExtractJwt, Strategy } from 'passport-jwt';

/**
 * The strategy to authorize users with JWTs.
 */
@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy, 'jwt') {
  /**
   * This creates a JwtStrategy with the required services.
   * @param {ConfigService} config - The service to access .env files
   * @param {PrismaService} prisma - The service to access the DB
   *
   * @constructor
   */
  constructor(
    config: ConfigService,
    private readonly prisma: PrismaService,
  ) {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      secretOrKey: config.get('JWT_SECRET'),
    });
  }

  /**
   * This function finds the user with information given in the JWT in the DB or throw an error if not found.
   * @param {{sub: number; email: string}} payload - The payload encrypted in the JWT
   * @returns {Promise<User>} - The user found in the DB
   */
  async validate(payload: { sub: number; email: string }): Promise<User> {
    const user = await this.prisma.user.findUniqueOrThrow({
      where: {
        id: payload.sub,
      },
    });

    delete user.passwordHash;

    return user;
  }
}
