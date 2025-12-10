import { Injectable } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

@Injectable()
export class TherapyService {
    async getResponse(question: string): Promise<string> {
        const lowerQuestion = question.toLowerCase();
        const therapies = await prisma.therapy.findMany();

        for (const therapy of therapies) {
            if (lowerQuestion.includes(therapy.keyword.toLowerCase())) {
                return therapy.response;
            }
        }

        return "Sorry, I don't have advice for that. Please try rephrasing your question.";
    }
}
