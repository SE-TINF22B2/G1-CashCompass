import { Account } from './account';
import { ApiProperty } from '@nestjs/swagger';
import { AccountType } from './account_type';

export class Category {
  @ApiProperty({ type: Number })
  id: number;

  @ApiProperty({ type: () => Account })
  account: AccountType;

  @ApiProperty({ type: Number })
  accountId: number;

  @ApiProperty({ type: String })
  color: string;

  @ApiProperty({ type: Number })
  budget: number;
}
