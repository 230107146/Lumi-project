// src/modules/users/dto/create-user.dto.ts
import { IsEmail, IsOptional, IsString, MinLength } from 'class-validator';

export class CreateUserDto {
	@IsEmail()
	email!: string;           // required field, definite assignment

	@IsString()
	@MinLength(6)
	password!: string;        // required field, definite assignment

	@IsOptional()
	@IsString()
	name?: string;            // optional field, no strict check needed
}


