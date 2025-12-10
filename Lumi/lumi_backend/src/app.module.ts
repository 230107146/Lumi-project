import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { UsersModule } from './modules/users/users.module';
import { AuthModule } from './modules/auth/auth.module';
import { TherapyModule } from './modules/therapy/therapy.module';
import { PrismaModule } from './prisma/prisma.module';

@Module({
    imports: [
        ConfigModule.forRoot({
            isGlobal: true, 
        }),
        PrismaModule,
        UsersModule,
        AuthModule,
        TherapyModule,
    ],
})
export class AppModule { }


