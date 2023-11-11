import { Module } from '@nestjs/common';
import { HealthController } from './health.controller';
import { PrismaModule } from 'nestjs-prisma';
import { MockEntityModule } from './mock-entity/mock-entity.module';
import { MailModule } from './mail/mail.module';
import { ConfigModule } from '@nestjs/config';
import { AuthModule } from './auth/auth.module';
import { ServeStaticModule } from '@nestjs/serve-static';
import { join } from 'path';
@Module({
  imports: [
    PrismaModule.forRoot({
      isGlobal: true,
    }),
    MockEntityModule,
    MailModule,
    ConfigModule.forRoot({ isGlobal: true }),
    AuthModule,
    ServeStaticModule.forRoot({
      rootPath: join(__dirname, '..', 'documentation'),
      serveRoot: '/doc',
    }),
  ],
  controllers: [HealthController],
})
export class AppModule {}
