import { Category } from './category';
import { FriendAccount } from './friend_account';
import { User } from './user';
import { Booking } from './booking';
import { RecurringTransaction } from './recurring_transaction';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { CategoryType } from './category_type';
import { FriendAccountType } from './friendaccount_type';
import { UserType } from './user_type';
import { BookingType } from './booking_type';
import { RecurringTransactionType } from './recurringtransaction_type';

export class Account {
  @ApiProperty({ type: Number })
  id: number;

  @ApiPropertyOptional({ type: () => Category })
  category?: CategoryType;

  @ApiPropertyOptional({ type: () => FriendAccount })
  FriendAccount?: FriendAccountType;

  @ApiProperty({ type: String })
  name: string;

  @ApiProperty({ type: () => User })
  user: UserType;

  @ApiProperty({ type: Number })
  userId: number;

  @ApiProperty({ isArray: true, type: () => Booking })
  activeBookings: BookingType[];

  @ApiProperty({ isArray: true, type: () => Booking })
  passiveBookings: BookingType[];

  @ApiProperty({ isArray: true, type: () => RecurringTransaction })
  activeRecurringTransactions: RecurringTransactionType[];

  @ApiProperty({ isArray: true, type: () => RecurringTransaction })
  passiveRecurringTransactions: RecurringTransactionType[];
}
