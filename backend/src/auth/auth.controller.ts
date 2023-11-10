import {
  Body,
  Controller,
  Get,
  HttpCode,
  HttpStatus,
  NotFoundException,
  Post,
  Req,
  UseGuards,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthDto } from './dto';
import { ApiTags } from '@nestjs/swagger';
import { GoogleOauthGuard } from './guard';
import { AccessTokenType } from './types';

/**
 * This is the controller for the user auth. It
 * contains all routes that can be called over the REST Api.
 */
@ApiTags('auth')
@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) { }

  /**
   * This is the route to sign a user in.
   * @param {AuthDto} dto - Contains the mail and password
   * @returns {Promise<AccessTokenType>} - The signed access token
   */
  @Post('signup')
  signup(@Body() dto: AuthDto): Promise<AccessTokenType> {
    return this.authService.signup(dto);
  }

  /**
   * This is the route to sign a user up.
   * @param {AuthDto} dto - Contains the mail and password
   * @returns {Promise<AccessTokenType>} - The signed access token
   */
  @HttpCode(HttpStatus.OK)
  @Post('signin')
  signin(@Body() dto: AuthDto): Promise<AccessTokenType> {
    return this.authService.signin(dto);
  }

  /**
   * This is the route to sign a user up or in with google.
   */
  @Get('google')
  @UseGuards(GoogleOauthGuard)
  // eslint-disable-next-line @typescript-eslint/no-empty-function
  async auth() { }

  /**
   * This is the callback to which google redirects.
   * It creates a signed token by signing the user in or up. 
   * @param {Express.Request} req - The express request object
   * @returns {Promise<AccessTokenType>} - The signed access token
   */
  @Get('google/callback')
  @UseGuards(GoogleOauthGuard)
  async googleAuthCallback(@Req() req: Express.Request): Promise<AccessTokenType> {
    console.log(req.user);

    //please add type here
    const user: any = req.user;

    let response: AccessTokenType;

    try {
      response = await this.authService.googleSignIn(user.email);
    } catch (error) {
      if (error instanceof NotFoundException) {
        response = await this.authService.googleSignup(user.email);
      } else {
        throw error;
      }
    }

    return response;
  }
}
