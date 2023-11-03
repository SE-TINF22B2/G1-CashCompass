import { Controller, Get, Post, Body, Patch, Param, Delete, ParseIntPipe } from '@nestjs/common';
import { MockEntityService } from './mock-entity.service';
import { CreateMockEntityDto, UpdateMockEntityDto } from './dto';
import { ApiCreatedResponse, ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { PrismaModel } from '../_gen/prisma-class';
import { MailService } from '../mail/mail.service';

@Controller('mock-entity')
@ApiTags('mock-entity')
export class MockEntityController {
  constructor(private readonly mockEntityService: MockEntityService, private readonly mailSerive: MailService) { }

  @Get()
  @ApiCreatedResponse({ type: PrismaModel.MockEntity, isArray: true })
  findAll() {
    return this.mockEntityService.findAll();
  }

  @Get(':id')
  @ApiOkResponse({ type: PrismaModel.MockEntity })
  findOne(@Param('id', ParseIntPipe) id: number) {
    return this.mockEntityService.findOne(id);
  }

  @Post()
  @ApiCreatedResponse({ type: PrismaModel.MockEntity })
  create(@Body() createMockEntityDto: CreateMockEntityDto) {
    return this.mockEntityService.create(createMockEntityDto);
  }

  @Patch(':id')
  @ApiOkResponse({ type: PrismaModel.MockEntity })
  update(@Param('id', ParseIntPipe) id: number, @Body() updateMockEntityDto: UpdateMockEntityDto) {
    return this.mockEntityService.update(id, updateMockEntityDto);
  }

  @Delete(':id')
  remove(@Param('id', ParseIntPipe) id: number) {
    return this.mockEntityService.remove(id);
  }

  @Get("mail/:adress")
  sendTestMail(@Param("adress") adress: string) {
    return this.mailSerive.sendTestMail(adress);
  }
}
