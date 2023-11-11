import { Controller, Get } from '@nestjs/common';

/**
 * This is the controller for a health check. This endpoint can be used just to check the status of the app.
 * It's also used for zero down time deploys.
 */
@Controller()
export class HealthController {

  /**
   * Created a HealthController.
   * 
   * @constructor
   */
  constructor() { }

  /**
   * This is the health check endpoint.
   * @returns The status of the api
   */
  @Get('health')
  getHealthCheck() {
    return { status: 200, text: 'Healthy' };
  }
}
