import { User } from './user';
import { FriendAccount } from './friend_account';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { UserType } from './user_type';
import { FriendAccountType } from './friendaccount_type';

export class Friendship {
  @ApiProperty({ type: Number })
  id: number;

  @ApiProperty({ type: () => User })
  user1: UserType;

  @ApiProperty({ type: Number })
  user1Id: number;

  @ApiProperty({ type: () => User })
  user2: UserType;

  @ApiProperty({ type: Number })
  user2Id: number;

  @ApiPropertyOptional({ type: () => FriendAccount })
  FriendAccount?: FriendAccountType;
}
