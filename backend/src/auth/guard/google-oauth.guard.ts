import { Injectable } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';

/**
 * This creates a new guard to access the google auth. Its just syntactic sugar to prevent typos.
 */
@Injectable()
export class GoogleOauthGuard extends AuthGuard('google') {}
