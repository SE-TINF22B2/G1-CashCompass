import { IsEmail, IsNotEmpty, IsString, MinLength } from 'class-validator';

export class CreateMockEntityDto {
  @IsEmail()
  @IsNotEmpty()
  email: string;
  @IsString()
  @IsNotEmpty()
  @MinLength(5)
  name: string;
}
