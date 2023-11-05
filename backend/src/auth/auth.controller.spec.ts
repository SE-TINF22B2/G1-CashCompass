import { Test, TestingModule } from '@nestjs/testing';
import { AuthController } from './auth.controller';
import { AuthService } from './auth.service';
import { AuthDto } from './dto';

const mockAuthService = {
  signup: jest.fn(),
  signin: jest.fn(),
};

describe('AuthController', () => {
  let controller: AuthController;
  let authService: AuthService;

  beforeEach(async () => {

    const module: TestingModule = await Test.createTestingModule({
      controllers: [AuthController],
      providers: [
        {
          provide: AuthService,
          useValue: mockAuthService,
        },
      ],
    }).compile();

    controller = module.get<AuthController>(AuthController);
    authService = module.get<AuthService>(AuthService);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  it('should call authService.signup with the provided dto', async () => {
    const authDto: AuthDto = {
      email: 'test@example.com',
      password: 'password123',
    };

    await controller.signup(authDto);

    expect(authService.signup).toHaveBeenCalledWith(authDto);
  });

  it('should call authService.signin with the provided dto', async () => {
    const authDto: AuthDto = {
      email: 'test@example.com',
      password: 'password123',
    };

    await controller.signin(authDto);

    expect(authService.signin).toHaveBeenCalledWith(authDto);
  });
});
