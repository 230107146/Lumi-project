import { Injectable, InternalServerErrorException, BadRequestException } from '@nestjs/common';
import { PrismaService } from '../../prisma/prisma.service'; // Adjust the path if needed
import * as bcrypt from 'bcrypt';
import { RegisterDto } from './dto/register.dto';

@Injectable()
export class AuthService {
  constructor(private readonly prisma: PrismaService) {}

  // Register a new user
  async register(registerDto: RegisterDto) {
    const { email, password } = registerDto;

    try {
      // Check if user already exists
      const existingUser = await this.prisma.user.findUnique({
        where: { email },
      });
      if (existingUser) {
        throw new BadRequestException('Email already in use');
      }

      // Hash the password
      const hashedPassword = await bcrypt.hash(password, 10);

      // Create the user
      const user = await this.prisma.user.create({
        data: {
          email,
          password: hashedPassword,
        },
      });

      return { message: 'User registered successfully', userId: user.id };
    } catch (error) {
      console.error(error);
      throw new InternalServerErrorException('Registration failed');
    }
  }

  // Login a user
  async login(email: string, password: string) {
    try {
      const user = await this.prisma.user.findUnique({
        where: { email },
      });

      if (!user) {
        throw new BadRequestException('Invalid credentials');
      }

      const isPasswordValid = await bcrypt.compare(password, user.password);
      if (!isPasswordValid) {
        throw new BadRequestException('Invalid credentials');
      }

      // You can add JWT token generation here if needed
      return { message: 'Login successful', userId: user.id };
    } catch (error) {
      console.error(error);
      throw new InternalServerErrorException('Login failed');
    }
  }
}
