import { Test, TestingModule } from '@nestjs/testing';
import { MockEntityService } from './mock-entity.service';

describe('MockEntityService', () => {
  let service: MockEntityService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [MockEntityService],
    }).compile();

    service = module.get<MockEntityService>(MockEntityService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
