import { HttpAdapterHost, NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import { PrismaModel } from './_gen/prisma-class';
import { PrismaClientExceptionFilter } from 'nestjs-prisma';
import { ValidationPipe } from '@nestjs/common';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  //Global exception filter
  const { httpAdapter } = app.get(HttpAdapterHost);
  app.useGlobalFilters(new PrismaClientExceptionFilter(httpAdapter));

  //Validation and transformation of inputs
  app.useGlobalPipes(new ValidationPipe());

  //Swagger
  const config = new DocumentBuilder()
    .setTitle('CashCompass')
    .setDescription('The CashCompass API description')
    .setVersion('0.1')
    .build();

  const document = SwaggerModule.createDocument(app, config, {
    extraModels: [...PrismaModel.extraModels],
  });
  SwaggerModule.setup('api', app, document);

  await app.listen(process.env.PORT || 3000);
}
bootstrap();
