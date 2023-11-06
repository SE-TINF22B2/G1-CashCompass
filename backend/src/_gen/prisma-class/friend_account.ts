import { Account } from './account';
import { Friendship } from './friendship';
import { ApiProperty } from '@nestjs/swagger';
import { AccountType } from './account_type';
import { FriendshipType } from './friendship_type';

export class FriendAccount {
  @ApiProperty({ type: Number })
  id: number;

  @ApiProperty({ type: () => Account })
  account: AccountType;

  @ApiProperty({ type: Number })
  accountId: number;

  @ApiProperty({ type: String })
  nickName: string;

  @ApiProperty({ type: () => Friendship })
  friendship: FriendshipType;

  @ApiProperty({ type: Number })
  friendshipId: number;
}
