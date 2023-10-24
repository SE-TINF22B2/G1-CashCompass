import { PartialType } from '@nestjs/mapped-types';
import { CreateMockEntityDto } from './create-mock-entity.dto';

export class UpdateMockEntityDto extends PartialType(CreateMockEntityDto) {}
