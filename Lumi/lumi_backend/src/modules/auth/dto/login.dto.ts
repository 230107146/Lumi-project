// src/modules/auth/dto/login.dto.ts
import { IsEmail, IsString, MinLength } from 'class-validator';

export class LoginDto {
    @IsEmail()
    email!: string;          // required field

    @IsString()
    @MinLength(6)
    password!: string;       // required field
}
