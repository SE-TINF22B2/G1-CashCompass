import { Test, TestingModule } from '@nestjs/testing';
import { MockEntityController } from './mock-entity.controller';
import { MockEntityService } from './mock-entity.service';
import { PrismaService } from 'nestjs-prisma';

describe('MockEntityController', () => {
  let controller: MockEntityController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [MockEntityController],
      providers: [MockEntityService, PrismaService],
    }).compile();

    controller = module.get<MockEntityController>(MockEntityController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
