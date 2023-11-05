import { MockEntity as _MockEntity } from './mock_entity';
import { User as _User } from './user';

export namespace PrismaModel {
  export class MockEntity extends _MockEntity {}
  export class User extends _User {}

  export const extraModels = [MockEntity, User];
}
