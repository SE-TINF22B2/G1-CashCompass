import { HttpAdapterHost, NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import { PrismaModel } from './_gen/prisma-class';
import { PrismaClientExceptionFilter } from 'nestjs-prisma';
import { ValidationPipe } from '@nestjs/common';

/**
 * This function bootstraps the nest application.
 * It registers global exception filters, global pipes for validation and transformation and the Swagger UI.
 */
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
    .addBearerAuth({ in: 'header', type: 'http' })
    .build();

  const document = SwaggerModule.createDocument(app, config, {
    extraModels: [...PrismaModel.extraModels],
  });
  SwaggerModule.setup('api', app, document);

  await app.listen(process.env.PORT || 3000);
}
bootstrap();
