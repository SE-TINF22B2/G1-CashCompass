import { MockEntity as _MockEntity } from './mock_entity';

export namespace PrismaModel {
  export class MockEntity extends _MockEntity {}

  export const extraModels = [MockEntity];
}
