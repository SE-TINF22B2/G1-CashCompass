import { Account } from './account';
import { ApiProperty } from '@nestjs/swagger';
import { AccountType } from './account_type';

export class Booking {
  @ApiProperty({ type: Number })
  id: number;

  @ApiProperty({ type: Number })
  amount: number;

  @ApiProperty({ type: () => Account })
  activeAccount: AccountType;

  @ApiProperty({ type: Number })
  activeAccountId: number;

  @ApiProperty({ type: () => Account })
  passiveAccount: AccountType;

  @ApiProperty({ type: Number })
  passiveAccountId: number;

  @ApiProperty({ type: Date })
  timestamp: Date;
}
