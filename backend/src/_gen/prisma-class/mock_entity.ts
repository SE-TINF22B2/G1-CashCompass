import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class MockEntity {
  @ApiProperty({ type: Number })
  id: number;

  @ApiProperty({ type: String })
  email: string;

  @ApiPropertyOptional({ type: String })
  name?: string;

  @ApiPropertyOptional({ type: String })
  test?: string;
}
