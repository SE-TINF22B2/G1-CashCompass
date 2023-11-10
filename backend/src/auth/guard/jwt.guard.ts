import { AuthGuard } from '@nestjs/passport';

/**
 * This creates a new Guard to protect routes. Its just syntactic sugar to prevent typos.
 */
export class JwtGuard extends AuthGuard('jwt') {
  /**
   * Just call the super constructor.
   */
  constructor() {
    super();
  }
}
