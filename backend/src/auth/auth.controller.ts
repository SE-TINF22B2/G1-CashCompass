import { Body, Controller, Get, HttpCode, HttpStatus, NotFoundException, Post, Req, UseGuards } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthDto } from './dto';
import { ApiTags } from '@nestjs/swagger';
import { GoogleOauthGuard } from './guard';

@ApiTags('auth')
@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) { }

  @Post('signup')
  signup(@Body() dto: AuthDto) {
    return this.authService.signup(dto);
  }

  @HttpCode(HttpStatus.OK)
  @Post('signin')
  signin(@Body() dto: AuthDto) {
    return this.authService.signin(dto);
  }

  @Get('google')
  @UseGuards(GoogleOauthGuard)
  // eslint-disable-next-line @typescript-eslint/no-empty-function
  async auth() { }

  @Get('google/callback')
  @UseGuards(GoogleOauthGuard)
  async googleAuthCallback(@Req() req) {
    console.log(req.user);

    //please add type here
    const user = req.user;

    let response;

    try {
      response = await this.authService.googleSignIn(req.user.email);
    } catch (error) {
      if (error instanceof NotFoundException) {
        response = await this.authService.googleSignup(req.user.email);
      } else {
        throw error;
      }
    }

    return response;
  }

}
