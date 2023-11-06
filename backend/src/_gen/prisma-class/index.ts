import { MockEntity as _MockEntity } from './mock_entity';
import { User as _User } from './user';
import { Account as _Account } from './account';
import { Booking as _Booking } from './booking';
import { Category as _Category } from './category';
import { FriendAccount as _FriendAccount } from './friend_account';
import { Friendship as _Friendship } from './friendship';
import { RecurringTransaction as _RecurringTransaction } from './recurring_transaction';

export namespace PrismaModel {
  export class MockEntity extends _MockEntity {}
  export class User extends _User {}
  export class Account extends _Account {}
  export class Booking extends _Booking {}
  export class Category extends _Category {}
  export class FriendAccount extends _FriendAccount {}
  export class Friendship extends _Friendship {}
  export class RecurringTransaction extends _RecurringTransaction {}

  export const extraModels = [
    MockEntity,
    User,
    Account,
    Booking,
    Category,
    FriendAccount,
    Friendship,
    RecurringTransaction,
  ];
}
