# Jikjjang-App

Jikjjang-App is a mobile application built with Flutter, designed to help foreigners living in Korea find job opportunities, access career resources, and connect with recruiters. This app offers users AI-driven career guidance, a professional profile feature, and job listings with detailed descriptions.

## Features

- **User and Recruiter Authentication**: Supports Google Sign-In for individual job seekers and recruiters.
- **Job Listings and Detailed Views**: Users can explore job listings categorized by field, view details, and apply.
- **Professional Profile**: Users can build a profile showcasing skills, experience, and career interests.
- **Company Management**: Recruiters can add company profiles and post job opportunities.
- **AI Career Guidance**: Personalized career insights and job recommendations for users.

## Screenshots
[Include screenshots of the app in action to give users a preview.]

## Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/jikjjang-app.git
   cd jikjjang-app
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Set up Firebase:**
   - Create a Firebase project.
   - Configure Firebase Authentication and Firestore.
   - Download `google-services.json` for Android and `GoogleService-Info.plist` for iOS, then add them to your `android/app` and `ios/Runner` directories, respectively.

4. **Run the app:**
   ```bash
   flutter run
   ```

## Project Structure

Here's an overview of the project's folder structure:

- `lib/`: Contains the main app code, including UI components and logic.
- `lib/screens/`: Screens for different parts of the app (Home, Job Details, Profile, Recruiter Dashboard).
- `lib/models/`: Data models representing users, jobs, companies, and other entities.
- `lib/services/`: Service files for Firebase interaction and data management.
- `lib/widgets/`: Custom reusable widgets for UI components.

## Usage

1. **Sign Up / Login**: Choose to sign in as a job seeker or recruiter. Both roles have unique dashboards and functionalities.
2. **Explore Job Listings**: The Home page provides a list of job openings, with filters by category.
3. **View Job Details**: Tap on a job listing to see a full job description and requirements.
4. **Profile Setup**: Build your profile by adding your professional background, skills, and goals.
5. **For Recruiters**: Create a company profile, add job listings, and manage applicants.

## Contributing

1. Fork this repository.
2. Create a new branch (`git checkout -b feature/YourFeature`).
3. Commit your changes (`git commit -am 'Add YourFeature'`).
4. Push the branch (`git push origin feature/YourFeature`).
5. Create a Pull Request.
