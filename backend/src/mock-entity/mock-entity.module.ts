import { Module } from '@nestjs/common';
import { MockEntityService } from './mock-entity.service';
import { MockEntityController } from './mock-entity.controller';
import { MailService } from '../mail/mail.service';

@Module({
  controllers: [MockEntityController],
  providers: [MockEntityService, MailService],
})
export class MockEntityModule {}
