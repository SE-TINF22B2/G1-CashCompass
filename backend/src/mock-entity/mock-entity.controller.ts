import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { MockEntityService } from './mock-entity.service';
import { CreateMockEntityDto, UpdateMockEntityDto } from './dto';
import { ApiCreatedResponse, ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { PrismaModel } from '../_gen/prisma-class';

@Controller('mock-entity')
@ApiTags('mock-entity')
export class MockEntityController {
  constructor(private readonly mockEntityService: MockEntityService) { }

  @Get()
  @ApiCreatedResponse({ type: PrismaModel.MockEntity, isArray: true })
  findAll() {
    return this.mockEntityService.findAll();
  }

  @Get(':id')
  @ApiOkResponse({ type: PrismaModel.MockEntity })
  findOne(@Param('id') id: string) {
    return this.mockEntityService.findOne(+id);
  }

  @Post()
  @ApiCreatedResponse({ type: PrismaModel.MockEntity })
  create(@Body() createMockEntityDto: CreateMockEntityDto) {
    return this.mockEntityService.create(createMockEntityDto);
  }

  @Patch(':id')
  @ApiOkResponse({ type: PrismaModel.MockEntity })
  update(@Param('id') id: string, @Body() updateMockEntityDto: UpdateMockEntityDto) {
    return this.mockEntityService.update(+id, updateMockEntityDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.mockEntityService.remove(+id);
  }
}
