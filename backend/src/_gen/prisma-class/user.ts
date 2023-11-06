import { Account } from './account';
import { Friendship } from './friendship';
import { ApiProperty } from '@nestjs/swagger';
import { AccountType } from './account_type';
import { FriendshipType } from './friendship_type';

export class User {
  @ApiProperty({ type: Number })
  id: number;

  @ApiProperty({ type: String })
  email: string;

  @ApiProperty({ type: String })
  passwordHash: string;

  @ApiProperty({ isArray: true, type: () => Account })
  account: AccountType[];

  @ApiProperty({ isArray: true, type: () => Friendship })
  myFriends: FriendshipType[];

  @ApiProperty({ isArray: true, type: () => Friendship })
  friendsWith: FriendshipType[];
}
