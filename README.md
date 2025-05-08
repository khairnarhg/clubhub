#  Club Hub – College Club Management System

**Club Hub** is a centralized digital platform to streamline and modernize the management of college clubs. It enhances communication, event planning, and membership tracking through a unified system tailored for students, faculty, and core committee members.

**Full Report:** [Project Report (Google Docs)](https://docs.google.com/document/d/1GrX6qqa0RR1yB_MXUvZB9WUGCemkG_r_/edit?usp=sharing)

---

##  Key Features

###  Student Interface
- View detailed club information: history, vision, events, and contact.
- Real-time notifications and feed for upcoming events.
- Commenting system on event posts.
- Enroll directly into events.
- Personalized dashboard & activity portfolio.
- Membership fee payment module.

###  Faculty Interface
- View all event announcements via a common feed.
- Approve event-related documents and permissions online.

###  Core Committee Interface
- Event planning and scheduling tools.
- Member recruitment and communication features.
- Upload brochures, manage queries and feedback.
- Maintain complete club database and records.

---

##  Tech Stack

| Layer         | Technologies Used          |
|---------------|-----------------------------|
| Frontend      | Flutter (Dart)              |
| Backend       | Firebase Authentication     |
| Database      | Cloud Firestore             |
| Platform Type | Cross-platform Mobile App   |

---

##  System Modules

- **Authentication:** Role-based sign-up/login (Students, Faculty, Core Members)
- **Event Management:** Event creation, scheduling, approval workflow
- **Communication:** Feed, announcements, notifications, and comments
- **Database:** Centralized club membership and event records
- **Resource Allocation:** Request & manage venues, equipment, and funding
- **Performance Monitoring:** Member participation tracking and analytics

---

##  Future Scope

- Online club elections with secure voting
- E-wallet payment integration
- Alumni engagement interface
- ML-driven insights for event planning and club performance
- Support for college-wide events like fests and exhibitions
- Expansion into a complete student management solution

---

##  How to Run

> This project is built using Flutter and Firebase. To run it locally:

```bash
# Clone the repo
git clone https://github.com/khairnarhg/club-hub.git
cd club-hub

# Get dependencies
flutter pub get

# Run on emulator or connected device
flutter run
