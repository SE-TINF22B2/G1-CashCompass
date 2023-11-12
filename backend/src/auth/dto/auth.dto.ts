import { IsEmail, IsNotEmpty, IsString } from 'class-validator';

/**
 * The DTO that is passed with each auth route.
 */
export class AuthDto {
  /**
   * The mail of the user.
   *
   * @type {string}
   * @memberof AuthDto
   */
  @IsNotEmpty()
  @IsEmail()
  email: string;
  /**
   * The password of the user.
   *
   * @type {string}
   * @memberof AuthDto
   */
  @IsNotEmpty()
  @IsString()
  password: string;
}
