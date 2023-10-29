import { Test, TestingModule } from '@nestjs/testing';
import { MockEntityService } from './mock-entity.service';
import { PrismaService } from 'nestjs-prisma';

describe('MockEntityService', () => {
  let service: MockEntityService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [MockEntityService, PrismaService],
    }).compile();

    service = module.get<MockEntityService>(MockEntityService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
