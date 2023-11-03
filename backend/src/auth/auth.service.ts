import { Injectable } from '@nestjs/common';
import { AuthDto } from './dto';

@Injectable()
export class AuthService {
    signin(dto: AuthDto) {
        throw new Error('Method not implemented.');
    }
    signup(dto: AuthDto) {
        throw new Error('Method not implemented.');
    }
}
