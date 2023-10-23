import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PrismaModule } from 'nestjs-prisma';
import { MockEntityModule } from './mock-entity/mock-entity.module';

@Module({
  imports: [PrismaModule.forRoot({
    isGlobal: true
  }), MockEntityModule,],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule { }
