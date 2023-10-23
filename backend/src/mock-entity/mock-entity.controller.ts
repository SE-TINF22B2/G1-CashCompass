import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { MockEntityService } from './mock-entity.service';
import { CreateMockEntityDto, UpdateMockEntityDto } from './dto';

@Controller('mock-entity')
export class MockEntityController {
  constructor(private readonly mockEntityService: MockEntityService) { }

  @Post()
  create(@Body() createMockEntityDto: CreateMockEntityDto) {
    return this.mockEntityService.create(createMockEntityDto);
  }

  @Get()
  findAll() {
    return this.mockEntityService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.mockEntityService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateMockEntityDto: UpdateMockEntityDto) {
    return this.mockEntityService.update(+id, updateMockEntityDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.mockEntityService.remove(+id);
  }
}
