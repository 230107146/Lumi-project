# System Architecture

## 1. Architecture Style
The system follows a client–server architecture.
This approach separates the presentation layer from data management and enables
scalability and maintainability.

## 2. System Components
The system consists of the following main components:
- Front end: Flutter-based mobile application (primary) with web support as a future extension
- UI/UX: designed and prototyped in Figma
- Back end: Firebase services
- Database: Firebase Firestore
- External services: Firebase Authentication, Firebase Analytics, Crashlytics

## 3. Component Interaction
The Flutter application communicates with Firebase services through secure APIs.
Firebase handles authentication, data storage, and analytics processing.

## 4. Data Flow
User interactions in the mobile application trigger actions within Flutter screens.
These actions call service-layer methods that communicate with Firebase APIs.
Data is stored in Firestore and synchronized back to the client application
for display and analysis.

## 5. Database Schema
The database includes the following main entities:
- Users: stores user authentication and profile data
- AddictionRecords: stores user-entered addiction tracking data
- Notifications: stores reminder and notification configurations

## 6. Technology Decisions
The following technologies were selected:
- Flutter: enables cross-platform development from a single codebase
- Firebase: provides managed authentication, real-time database, and scalability
- Firestore: flexible NoSQL database suitable for user-generated data

## 7. Future Extensions
Potential future improvements include:
- Machine learning–based recommendations
- Multi-addiction tracking support
- Web-based dashboard
- Advanced analytics and reporting
