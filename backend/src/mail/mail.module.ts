import { Module } from '@nestjs/common';
import { MailService } from './mail.service';

/**
 * This is the module that is responsible for sending mails.
 */
@Module({
  providers: [MailService],
})
export class MailModule {}
