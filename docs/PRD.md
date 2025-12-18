# Product Requirements Document (PRD)

## 1. Product Goal
The goal of the product is to provide users with a simple and structured tool to track, monitor, and reduce harmful addictive behaviors through a cross-platform application available on both mobile and web.

## 2. Problem Statement
Many individuals who struggle with addictions lack effective and accessible tools to monitor their behavior, recognize patterns, and maintain motivation. Existing solutions often focus on general habit tracking and do not adequately address addiction-specific needs.

## 3. Target Audience
- Students  
- Young adults  
- Individuals seeking to reduce addictive behaviors  

## 4. User Roles
| Role          | Description                                           |
|---------------|-------------------------------------------------------|
| User          | Tracks personal addictive behavior and views progress |
| Administrator | Manages system configuration and monitoring           |

## 5. User Scenarios
Users interact with the system through mobile and web interfaces designed and prototyped in Figma. Users can:  
- Register and log in securely.  
- Select addictive behaviors to track.  
- Log daily behavior entries.  
- Receive reminders and notifications.  
- View progress through analytics dashboards on mobile or web.  
- Access offline functionality on mobile devices.  

The web version is fully functional and provides the same core features as the mobile app, ensuring cross-platform consistency.

## 6. Functional Requirements
The system must:  
1. Allow users to register and authenticate securely.  
2. Allow users to select and track addictive behaviors.  
3. Allow users to create, edit, and view tracking entries.  
4. Display progress statistics and trends.  
5. Send reminders and notifications to users.  
6. Synchronize data across mobile and web platforms.  

## 7. Non-Functional Requirements
- **Performance:** application responses within 2 seconds.  
- **Reliability:** consistent data storage without data loss.  
- **Security:** authenticated access and protected user data.  
- **Usability:** simple, intuitive, and accessible user interface.  
- **Scalability:** ability to support an increasing number of users across mobile and web.  

## 8. MVP Scope
Version 0.1 must include:  
- User authentication  
- Addiction tracking functionality  
- Basic analytics and progress visualization  
- Reminder and notification system  
- Cross-platform support (mobile and web)  

## 9. Out-of-Scope Features
- Social or community features  
- Therapist or professional integration  
- Advanced AI-based recommendations  
- Gamification elements  

## 10. Acceptance Criteria
- **Authentication:** users can successfully register and log in using valid credentials.  
- **Tracking:** users can create, update, and view addiction tracking records on mobile and web.  
- **Analytics:** progress data is displayed accurately and consistently.  
- **Notifications:** reminders are delivered according to user settings on both platforms.  
- **Cross-Platform Functionality:** data synchronization between mobile and web works seamlessly.

## 11. Frontend Development (Flutter)
| Module                     | Description                                              | Platform       |
|-----------------------------|----------------------------------------------------------|----------------|
| Flutter Setup               | Project initialization and dependency setup             | Mobile & Web  |
| Authentication              | Login, registration, and secure user management         | Mobile & Web  |
| Tracking Module             | Create, edit, view addictive behavior logs              | Mobile & Web  |
| Notifications & Reminders   | Scheduled reminders and push notifications              | Mobile & Web  |
| Offline Sync Logic          | Sync offline entries with cloud when online             | Mobile        |
| Analytics Dashboard         | Display charts, trends, and progress stats             | Mobile & Web  |
| Multi-Addiction Support     | Track multiple addictions per user                       | Mobile & Web  |
| Input Validation & Error Handling | Ensure correct data entry and handle exceptions   | Mobile & Web  |

