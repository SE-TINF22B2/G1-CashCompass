import { Test, TestingModule } from '@nestjs/testing';
import { HealthController } from './health.controller';

describe('HealthController', () => {
  let healthController: HealthController;

  beforeEach(async () => {
    const app: TestingModule = await Test.createTestingModule({
      controllers: [HealthController],
    }).compile();

    healthController = app.get<HealthController>(HealthController);
  });

  describe('getHealthCheck', () => {
    it('should return healthy', () => {
      expect(healthController.getHealthCheck()).toStrictEqual({
        status: 200,
        text: 'Healthy',
      });
    });
  });
});
