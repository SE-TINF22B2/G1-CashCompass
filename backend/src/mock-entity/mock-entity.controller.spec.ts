import { Test, TestingModule } from '@nestjs/testing';
import { MockEntityController } from './mock-entity.controller';
import { MockEntityService } from './mock-entity.service';
import { PrismaService } from 'nestjs-prisma';
import { MailService } from '../mail/mail.service';
import { ConfigService } from '@nestjs/config';

describe('MockEntityController', () => {
  let controller: MockEntityController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [MockEntityController],
      providers: [MockEntityService, PrismaService, MailService, ConfigService],
    }).compile();

    controller = module.get<MockEntityController>(MockEntityController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
