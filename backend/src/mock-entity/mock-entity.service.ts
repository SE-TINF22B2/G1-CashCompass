import { Injectable } from '@nestjs/common';
import { CreateMockEntityDto, UpdateMockEntityDto } from './dto';
import { PrismaService } from 'nestjs-prisma';

@Injectable()
export class MockEntityService {

  constructor(private prismaService: PrismaService) { }

  create(createMockEntityDto: CreateMockEntityDto) {
    return this.prismaService.mockEntity.create({
      data: {
        ...createMockEntityDto
      }
    })
  }

  findAll() {
    return this.prismaService.mockEntity.findMany();
  }

  findOne(id: number) {
    return this.prismaService.mockEntity.findUniqueOrThrow({
      where: {
        id
      }
    });
  }

  update(id: number, updateMockEntityDto: UpdateMockEntityDto) {
    return this.prismaService.mockEntity.update({
      data: updateMockEntityDto,
      where: {
        id
      }
    });
  }

  remove(id: number) {
    return this.prismaService.mockEntity.delete({
      where: {
        id
      }
    });
  }
}
