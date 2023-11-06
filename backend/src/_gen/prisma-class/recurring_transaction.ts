import { Account } from './account';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { AccountType } from './account_type';

export class RecurringTransaction {
  @ApiProperty({ type: Number })
  id: number;

  @ApiProperty({ type: Number })
  amount: number;

  @ApiProperty({ type: Date })
  startDate: Date;

  @ApiPropertyOptional({ type: Date })
  endDate?: Date;

  @ApiProperty({ type: String })
  interval: string;

  @ApiProperty({ type: () => Account })
  activeAccount: AccountType;

  @ApiProperty({ type: Number })
  activeAccountId: number;

  @ApiProperty({ type: () => Account })
  passiveAccount: AccountType;

  @ApiProperty({ type: Number })
  passiveAccountId: number;
}
