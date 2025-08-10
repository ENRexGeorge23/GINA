<div align="center">
<!--   <img src="httpsa://raw.githubusercontent.com/your-repo/your-project/main/assets/images/gina_logo.png" alt="GINA Logo" width="150"/> -->
  <h1>GINA</h1>
  <p><i>Your Guide, Your Health, Your Space</i></p>
  <p>A comprehensive mobile application connecting patients with gynecologists, fostering a community for women's health, and streamlining administrative oversight.</p>
</div>

---

## ✨ Main Purpose

**GINA** is a dedicated healthcare platform designed to empower women by providing easy access to gynecological care and information. It serves as a tripartite ecosystem where:

*   **Patients** can track their menstrual cycles, find specialized doctors, book appointments, engage in secure consultations, and participate in supportive community forums.
*   **Doctors** can manage their schedules, handle patient appointments, conduct e-consultations, and build their professional reputation by contributing to forums.
*   **Admins** can oversee the platform's integrity by verifying medical professionals and managing the user base, ensuring a safe and trusted environment for everyone.

---

## 🚀 Features

### 🌸 For Patients

*   **Authentication**: Secure Sign-up and Login functionality.
*   **Home Dashboard**: A personalized overview with quick access to key features like period tracking, appointment booking, and forums.
*   **Find Doctors**: An intelligent search feature to find doctors nearby or in specific cities.
*   **Doctor Profiles**: View detailed doctor profiles, including their specialty, availability, office address, and consultation fees.
*   **Appointment Management**: Seamlessly book, view, reschedule, or cancel appointments.
*   **E-Consultation**: Engage in secure, private chat consultations with doctors.
*   **Period Tracker & Cycle History**: Log and monitor menstrual cycles with predictive insights.
*   **Community Forums**: Ask questions, share experiences, and connect with a community of patients and verified doctors.
*   **Profile Management**: Easily view and update personal information.
*   **Emergency Announcements**: Receive critical announcements directly from doctors.

### 👩‍⚕️ For Doctors

*   **Secure Onboarding**: A multi-step registration and verification process.
*   **Dashboard**: A central hub to view upcoming appointments and pending requests at a glance.
*   **Schedule Management**: Create and manage weekly schedules, setting office days and hours.
*   **Appointment Requests**: Efficiently view, approve, and decline patient appointment requests.
*   **E-Consultation**: A dedicated interface for conducting online chat consultations.
*   **Patient Management**: Access a comprehensive list of patients and view their detailed history.
*   **Consultation Fee Management**: Set and display consultation fees for both online and face-to-face appointments.
*   **Forum Engagement**: Participate in forums, answer questions, and earn badges (New, Contributing, Active, Top Doctor) to build credibility.
*   **Emergency Announcements**: Broadcast urgent messages to all subscribed patients.
*   **Profile Management**: Update professional and contact information.

### 💻 For Administrators

*   **Admin Dashboard**: An overview of key platform metrics, including total patients, verified doctors, and pending verifications.
*   **Doctor Verification**: A robust system to review, approve, or decline doctor registrations based on submitted credentials.
*   **User Management**: View and manage comprehensive lists of all registered doctors and patients on the platform.
*   **Appointment Oversight**: Access a complete history of all appointments booked through the application.

---

## 🏛️ Architecture

The application is built using a modern, scalable, and feature-driven architecture to ensure maintainability and high performance.

### 1. Feature-First Structure

The project is organized by features (`/lib/features`), not by technical layers (e.g., UI, logic). Each feature module is self-contained and includes all the necessary components for its functionality. This approach enhances modularity, making the codebase easier to navigate, scale, and maintain.

A typical feature directory (`e.g., /lib/features/patient_features/appointment`) is structured as follows:
*   `0_models`: Defines the data structures (e.g., `AppointmentModel`).
*   `1_controllers`: Contains the business logic and data manipulation (e.g., fetching data from Firebase).
*   `2_views`: Holds the UI components, which are further divided into:
    *   `bloc`: State management files.
    *   `screens`: The main screens for the feature.
    *   `widgets`: Reusable UI components specific to that feature.

### 2. State Management: BLoC (Business Logic Component)

We leverage the **BLoC pattern** for state management. This architectural choice strictly separates the business logic from the UI, resulting in code that is:
*   **Testable**: Business logic can be tested independently of the UI.
*   **Reactive**: The UI updates automatically in response to state changes.
*   **Consistent**: Provides a predictable and unidirectional data flow (Events -> BLoC -> States).

Each feature has its own dedicated BLoC (`_bloc.dart`), which processes events (`_event.dart`) and emits states (`_state.dart`).

### 3. Dependency Injection

The project uses the `get_it` package for service location and dependency injection, as configured in `dependencies_injection.dart`. This decouples the application's components and makes it easy to provide and access dependencies (like controllers and BLoCs) throughout the widget tree without tightly coupling them.

### 4. Core & Reusable Components

A central `core` directory (`/lib/core`) houses shared functionalities that are used across multiple features. This includes:
*   **`reusable_widgets`**: Common UI elements like custom buttons and app bars.
*   **`theme`**: The application's visual theme and styling.
*   **`route`**: Centralized app navigation routes.
*   **`error`**: Custom failure and exception handling.

This architecture ensures a clean, organized, and robust foundation for the GINA application.
