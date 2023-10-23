import { Injectable } from '@nestjs/common';
import { CreateMockEntityDto, UpdateMockEntityDto } from './dto';
import { PrismaService } from 'nestjs-prisma';

@Injectable()
export class MockEntityService {

  constructor(private prismaService: PrismaService) { }

  create(createMockEntityDto: CreateMockEntityDto) {
    return 'This action adds a new mockEntity';
  }

  findAll() {
    return `This action returns all mockEntity`;
  }

  findOne(id: number) {
    return `This action returns a #${id} mockEntity`;
  }

  update(id: number, updateMockEntityDto: UpdateMockEntityDto) {
    return `This action updates a #${id} mockEntity`;
  }

  remove(id: number) {
    return `This action removes a #${id} mockEntity`;
  }
}
