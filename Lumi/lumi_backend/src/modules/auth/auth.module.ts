import { Module } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { JwtModule } from '@nestjs/jwt';
import { PrismaModule } from '../../prisma/prisma.module'; // adjust path as needed

@Module({
  imports: [
    PrismaModule, // <-- needed for AuthService
    JwtModule.register({
      secret: process.env.JWT_SECRET || 'change_this',
      signOptions: { expiresIn: '7d' },
    }),
  ],
  controllers: [AuthController],
  providers: [AuthService],
})
export class AuthModule {}

