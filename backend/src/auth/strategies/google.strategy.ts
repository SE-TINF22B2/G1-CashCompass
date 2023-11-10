import { Inject, Injectable } from '@nestjs/common';
import { ConfigService, ConfigType } from '@nestjs/config';
import { PassportStrategy } from '@nestjs/passport';
import { Strategy, VerifyCallback } from 'passport-google-oauth2';

/**
 * The strategy to authenticate users with google.
 */
@Injectable()
export class GoogleStrategy extends PassportStrategy(Strategy, 'google') {
  /**
   * This creates a GoogleStrategy with the given services.
   * @param {ConfigService} configService - The service to access .env files
   */
  constructor(readonly configService: ConfigService) {
    super({
      clientID: configService.get('clientID'),
      clientSecret: configService.get('clientSecret'),
      callbackURL: configService.get('callbackURL'),
      scope: ['profile', 'email'],
    });
  }

  /**
   * This function validates a user and extracts the needed information from the google user.
   * @param {string} _accessToken - The access token (not used)
   * @param {string}  _refreshToken - The refresh token (not used)
   * @param  {any} profile - The profile of the user
   * @param {VerifyCallback} done - The callback to be called when finished
   *
   */
  async validate(
    _accessToken: string,
    _refreshToken: string,
    profile: any,
    done: VerifyCallback,
  ): Promise<any> {
    const { id, name, emails, photos } = profile;

    const user = {
      provider: 'google',
      providerId: id,
      email: emails[0].value,
      name: `${name.givenName} ${name.familyName}`,
      picture: photos[0].value,
    };

    done(null, user);
  }
}
