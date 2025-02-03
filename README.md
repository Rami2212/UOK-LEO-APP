# UOK-LEO-APP

## 📌 Project Description
UOK-LEO-APP is a mobile application developed using **Flutter** with a **Spring Boot** backend for the **LEO Club of the University of Kelaniya**. This app enables club members to explore and interact with club activities, including **projects, achievements, evaluations, and notifications**. It provides role-based access, allowing directors to request project dates and admins to manage the system.

## 🎯 Features
### 🌍 General Users (Club Members)
- View **club projects** with details.
- Check **club achievements** and **evaluations**.
- Receive **notifications** about upcoming projects.
- View projects on a **calendar**.
- Create and manage **user accounts**.

### 🎓 Director Role
- All the above features.
- Request **project dates** using a calendar-based **date request form**.

### 🔧 Admin Role
- All the above features.
- Add, edit, and delete **projects**.
- Manage **club achievements**.
- Add and update **evaluations**.
- Approve or reject **date bookings**.
- Manage user accounts (**add, edit, delete, filter users**).

## 🏗️ Tech Stack
### **Frontend (Flutter)**
- **Flutter** (Dart)
- **Provider / Riverpod** (State Management)
- **Dio** (API Calls)
- **TableCalendar** (Calendar View)
- **Flutter Secure Storage** (Authentication Token Storage)

### **Backend (Spring Boot)**
- **Spring Boot** (Java)
- **Spring Security** (Authentication & Authorization)
- **Spring Data JPA** (Database ORM)
- **MySQL** (Database)
- **JWT Authentication**

## 🛠️ Setup Instructions
### 📌 Prerequisites
- Install [Flutter](https://flutter.dev/docs/get-started/install)
- Install [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/)
- Install Java (JDK 11 or higher) for the backend
- Install MySQL for database management
- Install Git

### 🔧 Clone the Repository
```bash
git clone https://github.com/yourusername/UOK-LEO-APP.git
cd UOK-LEO-APP
```

### 🚀 Frontend Setup (Flutter)
```bash
flutter pub get
flutter run
```

### 🚀 Backend Setup (Spring Boot)
1. Navigate to the backend folder:
```bash
cd backend
```
2. Build and run the Spring Boot application:
```bash
./mvnw spring-boot:run
```
3. Ensure MySQL is running and update `application.properties` with your database credentials.

## 🔐 Authentication & Authorization
- Uses **JWT (JSON Web Token)** for secure authentication.
- User roles are managed in the backend (**User, Director, Admin**).
- Flutter stores the token securely using `flutter_secure_storage`.

## 📅 Calendar Feature
- Uses **TableCalendar** package for project date management.
- Directors can request dates; Admins can approve/reject requests.

## 📜 API Endpoints (Backend)
| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/auth/register` | User registration |
| POST | `/auth/login` | User login |
| GET | `/projects` | Get all projects |
| POST | `/projects` | Create a project (Admin only) |
| PUT | `/projects/{id}` | Update a project (Admin only) |
| DELETE | `/projects/{id}` | Delete a project (Admin only) |
| GET | `/achievements` | View club achievements |
| POST | `/achievements` | Add an achievement (Admin only) |
| GET | `/evaluations` | View evaluations |
| POST | `/evaluations` | Add an evaluation (Admin only) |
| POST | `/calendar/book` | Request a project date (Director only) |
| GET | `/calendar/pending` | View pending project bookings (Admin only) |
| PUT | `/calendar/approve/{id}` | Approve a project date (Admin only) |
| DELETE | `/calendar/reject/{id}` | Reject a project date (Admin only) |

## 🛡️ Security & Permissions
- **JWT-based authentication** ensures secure access.
- **Role-based access control (RBAC)** allows different users to access only their assigned features.
- **Data validation & error handling** to maintain app integrity.

## 🤝 Contribution Guidelines
1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Commit your changes (`git commit -m 'Added new feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Create a Pull Request.

## 📝 License
This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for more details.

## 🌟 Contact
For any queries, feel free to contact us at **leo-club@uok.lk**.

