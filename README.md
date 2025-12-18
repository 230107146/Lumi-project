# Lumi – Addiction Tracking MVP

## Overview
Lumi is an addiction tracking application developed as a Minimum Viable Product (MVP).
The product addresses the problem of low self-awareness and lack of structured tools for
individuals who want to reduce harmful addictive behaviors.

The solution enables users to track addictive behavior, receive reminders,
and view basic progress analytics.

The MVP is implemented primarily as a mobile application.  
A web version is considered as a possible future extension.

The target users are individuals seeking to monitor and reduce addictive behaviors.

## Tech Stack
- Front end (Mobile): Flutter
- Front end (Web – planned): Flutter Web
- Back end: Firebase
- Database: Firestore
- Other tools: Firebase Authentication, Firebase Analytics, Figma, GitHub

## Project Structure
- /lib — main Flutter application source code
- /lib/screens — UI screens for mobile and web interfaces
- /lib/services — Firebase integration and business logic
- /lib/models — data models
- /test — automated tests
- /docs — project documentation (PRD, Architecture, API, User Stories)

## How to Run the Project
System requirements:
- Flutter SDK
- Firebase account
- Supported platforms: Android, iOS, Web

Installation steps:
1. Clone the repository
2. Install Flutter dependencies
3. Configure environment variables

Start command:
```bash
flutter run
