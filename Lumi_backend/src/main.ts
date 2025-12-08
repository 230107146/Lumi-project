import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ValidationPipe } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

async function bootstrap() {
    const app = await NestFactory.create(AppModule);

    // Validation
    app.useGlobalPipes(new ValidationPipe());

    // CORS
    app.enableCors({
        origin: "*", // or your frontend URL
        methods: "*",
    });

    // Config
    const config = app.get(ConfigService);
    const port = config.get<number>('PORT', 3000);

    await app.listen(port);
    console.log(`Server listening on port ${port}`);
}

bootstrap();


// Compare this snippet from lumi_backend/src/modules/therapy/therapy.module.ts:
