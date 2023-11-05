import { Test, TestingModule } from '@nestjs/testing';
import { AuthService } from './auth.service';
import { JwtService } from '@nestjs/jwt';
import { ConfigService } from '@nestjs/config';
import { ForbiddenException } from '@nestjs/common';
import { PrismaService } from 'nestjs-prisma';
import * as argon2 from 'argon2'; // Importieren Sie das Argon2-Modul

jest.mock('argon2');
(argon2.hash as jest.Mock).mockResolvedValue("hashed_password");
(argon2.verify as jest.Mock).mockImplementation((hash, password) => hash === 'hashed_password' && password === 'password123');

const prismaServiceMock = {
  user: {
    findUnique: jest.fn().mockResolvedValue({
      id: 1,
      email: "test@example.com",
      passwordHash: 'hashed_password',
    }),
    create: jest.fn().mockResolvedValue({
      id: 1,
      email: 'test@example.com',
      passwordHash: 'hashed_password',
    }),
  }
};

const configServiceMock = {
  get: jest.fn().mockReturnValue('your_secret_key'),
};

const jwtServiceMock = {
  signAsync: jest.fn().mockResolvedValue('jwt_token'),
};

describe('AuthService', () => {
  let service: AuthService;

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

    service = module.get<AuthService>(AuthService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  it('should create a new user and sign a token for signup', async () => {
    const authDto = {
      email: 'test@example.com',
      password: 'password123',
    };

    const result = await service.signup(authDto);

    expect(result).toEqual({ access_token: 'jwt_token' });
    expect(prismaServiceMock.user.create).toHaveBeenCalledWith({
      data: {
        email: authDto.email,
        passwordHash: 'hashed_password',
      },
    });
    expect(jwtServiceMock.signAsync).toHaveBeenCalledWith({ sub: 1, email: authDto.email }, { expiresIn: '15m', secret: 'your_secret_key' });
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

    const result = await service.signin(authDto);

    expect(result).toEqual({ access_token: 'jwt_token' });
    expect(jwtServiceMock.signAsync).toHaveBeenCalledWith({ sub: 1, email: authDto.email }, { expiresIn: '15m', secret: 'your_secret_key' });
  });

});
