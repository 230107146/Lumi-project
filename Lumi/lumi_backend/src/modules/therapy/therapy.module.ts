import { Module } from '@nestjs/common';
import { TherapyService } from './therapy.service';
import { TherapyController } from './therapy.controller';
import { PrismaClient } from '@prisma/client';

@Module({
    controllers: [TherapyController],
    providers: [TherapyService, PrismaClient],
})
export class TherapyModule { }
