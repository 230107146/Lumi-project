// src/modules/auth/dto/register.dto.ts
import { IsEmail, IsString, MinLength } from 'class-validator';

export class RegisterDto {
    @IsEmail()
    email!: string;          // required field

    @IsString()
    @MinLength(6)
    password!: string;       // required field
}
