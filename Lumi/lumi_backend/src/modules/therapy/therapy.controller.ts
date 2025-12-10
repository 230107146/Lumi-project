import { Controller, Post, Body } from '@nestjs/common';
import { TherapyService } from './therapy.service';
import { AskTherapyDto } from './dto/ask-therapy.dto';

@Controller('therapy') 
export class TherapyController {
    constructor(private therapyService: TherapyService) {}

    @Post('ask') 
    async ask(@Body('question') question: string) {
        const response = await this.therapyService.getResponse(question);
        return { question, response };
    }
}
