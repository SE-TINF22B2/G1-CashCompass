import { Module } from '@nestjs/common';
import { MockEntityService } from './mock-entity.service';
import { MockEntityController } from './mock-entity.controller';

@Module({
  controllers: [MockEntityController],
  providers: [MockEntityService],
})
export class MockEntityModule {}
