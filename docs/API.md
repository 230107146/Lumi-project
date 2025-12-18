# API Specification

## Overview
This document describes the logical API used by the Lumi MVP.
The application uses Firebase services as the backend.
The API is defined at a conceptual level to describe how the front end
communicates with authentication and data storage services.

## Base URL
Firebase services are accessed via official Firebase SDKs.
Example base URL:
https://firebase.googleapis.com

---

## Authentication API

### Register User
Endpoint: /auth/register  
Method: POST  
Purpose: Create a new user account

Request Body:
```json
{
  "email": "user@example.com",
  "password": "password123"
}
