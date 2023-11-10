import { Test, TestingModule } from '@nestjs/testing';
import { AuthService } from './auth.service';
import { JwtService } from '@nestjs/jwt';
import { ConfigService } from '@nestjs/config';
import { ForbiddenException, NotFoundException } from '@nestjs/common';
import { PrismaService } from 'nestjs-prisma';
import * as argon2 from 'argon2';

jest.mock('argon2');
(argon2.hash as jest.Mock).mockResolvedValue('hashed_password');
(argon2.verify as jest.Mock).mockImplementation(
  (hash, password) => hash === 'hashed_password' && password === 'password123',
);

const prismaServiceMock = {
  user: {
    findUnique: jest.fn().mockResolvedValue({
      id: 1,
      email: 'test@example.com',
      passwordHash: 'hashed_password',
    }),
    create: jest.fn().mockResolvedValue({
      id: 1,
      email: 'test@example.com',
      passwordHash: 'hashed_password',
    }),
  },
};

const configServiceMock = {
  get: jest.fn().mockReturnValue('jwt_secret'),
};

const jwtServiceMock = {
  signAsync: jest.fn().mockResolvedValue('jwt_token'),
};

describe('AuthService', () => {
  let authService: AuthService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        AuthService,
        {
          provide: PrismaService,
          useValue: prismaServiceMock,
        },
        {
          provide: ConfigService,
          useValue: configServiceMock,
        },
        {
          provide: JwtService,
          useValue: jwtServiceMock,
        },
      ],
    }).compile();

    authService = module.get<AuthService>(AuthService);
  });

  it('should be defined', () => {
    expect(authService).toBeDefined();
  });

  it('should create a new user and sign a token for signup', async () => {
    const authDto = {
      email: 'test@example.com',
      password: 'password123',
    };

    const result = await authService.signup(authDto);

    expect(result).toEqual({ access_token: 'jwt_token' });
    expect(prismaServiceMock.user.create).toHaveBeenCalledWith({
      data: {
        email: authDto.email,
        passwordHash: 'hashed_password',
      },
    });
    expect(jwtServiceMock.signAsync).toHaveBeenCalledWith(
      { sub: 1, email: authDto.email },
      { expiresIn: '15m', secret: 'jwt_secret' },
    );
  });

  it('should create a new user and sign a token for signup with google', async () => {
    const mail = 'test@example.com';

    prismaServiceMock.user.create.mockResolvedValue({
      id: 1,
      email: mail,
    });

    const result = await authService.googleSignup(mail);

    expect(result).toEqual({ access_token: 'jwt_token' });
    expect(prismaServiceMock.user.create).toHaveBeenCalledWith({
      data: {
        email: mail,
      },
    });
    expect(jwtServiceMock.signAsync).toHaveBeenCalledWith(
      { sub: 1, email: mail },
      { expiresIn: '15m', secret: 'jwt_secret' },
    );
  });

  it('should sign a token for signin with correct credentials', async () => {
    const authDto = {
      email: 'test@example.com',
      password: 'password123',
    };

    prismaServiceMock.user.findUnique.mockResolvedValue({
      id: 1,
      email: authDto.email,
      passwordHash: 'hashed_password',
    });

    const result = await authService.signin(authDto);

    expect(result).toEqual({ access_token: 'jwt_token' });
    expect(jwtServiceMock.signAsync).toHaveBeenCalledWith(
      { sub: 1, email: authDto.email },
      { expiresIn: '15m', secret: 'jwt_secret' },
    );
  });

  it('should sign a token for signin with correct credentials with google', async () => {
    const mail = 'test@example.com';

    prismaServiceMock.user.findUnique.mockResolvedValue({
      id: 1,
      email: mail,
    });

    const result = await authService.googleSignIn(mail);

    expect(result).toEqual({ access_token: 'jwt_token' });
    expect(jwtServiceMock.signAsync).toHaveBeenCalledWith(
      { sub: 1, email: mail },
      { expiresIn: '15m', secret: 'jwt_secret' },
    );
  });

  it('should sign a token with the signToken function', async () => {
    const result = await authService.signToken(1, 'test@example.com');

    expect(result).toEqual({ access_token: 'jwt_token' });
    expect(jwtServiceMock.signAsync).toHaveBeenCalledWith(
      { sub: 1, email: 'test@example.com' },
      { expiresIn: '15m', secret: 'jwt_secret' },
    );
  });

  it('should throw ForbiddenException for signin with incorrect password', async () => {
    const authDto = {
      email: 'test@example.com',
      password: 'wrong_password',
    };

    try {
      const result = await authService.signin(authDto);
      expect(result).toBe(undefined); //just to make the test fail in case no exception is thrown
    } catch (error) {
      expect(error).toBeInstanceOf(ForbiddenException);
      expect(error.message).toBe('Credentials incorrect');
    }
  });

  it('should throw ForbiddenException for signin if user not found', async () => {
    const authDto = {
      email: 'notfound@example.com',
      password: 'password123',
    };

    //mock that no user is found
    prismaServiceMock.user.findUnique.mockResolvedValue(undefined);

    try {
      const result = await authService.signin(authDto);
      expect(result).toBe(undefined); //just to make the test fail in case no exception is thrown
    } catch (error) {
      expect(error).toBeInstanceOf(NotFoundException);
      expect(error.message).toBe('User not found');
    }
  });
});
