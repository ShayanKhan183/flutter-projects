
# 🚌 Real-Time Bus Tracker – Flutter + Firebase App  

A **real-time bus tracking application** built with Flutter, Firebase, and Google Maps API.  
This app enables **students** to track buses in real time and **drivers** to update their live locations.  

---

## 📌 Project Documentation  

**Supervisor:** Sir Shahzaib  
**Submitted By:**  
- Shayan Adil Khan (BCS-F22-E13)  
**Department of Computer Science, University of Mianwali, Punjab**  
---

## 🚀 Introduction  

The Real-Time Bus Tracker app is designed to:  
- Allow **students** to view bus locations on a map.  
- Enable **drivers** to update their **current location** in real time.  
- Provide **separate logins** for students and drivers.  
- Use **Firebase** for authentication and location storage.  
- Use **Google Maps API** for location tracking & map rendering.  

---

## ❗ Problem Statement  

Many students face difficulty knowing **when buses will arrive** or **where they are**.  
There’s no proper system to track buses in real time, which causes **delays and uncertainty**.  

---

## 🎯 Purpose / Solution  

The app solves these problems by:  
✅ Allowing **drivers** to update live bus location  
✅ Allowing **students** to track buses on Google Maps  
✅ Providing **separate logins** for students & drivers  
✅ Storing location & user details in Firebase  

---

## 🛠️ Tools & Technologies  

- **Flutter** – Cross-platform mobile development  
- **Dart** – Programming language  
- **Firebase Authentication** – Login & Signup  
- **Firebase Firestore** – Real-time database  
- **Firebase Realtime DB (optional)** – Location tracking  
- **Google Maps API** – Location services & live map  
- **Android Studio / VS Code** – IDEs  
- **GitHub** – Version control  

---

## 🎯 Key Objectives  

1. Build a real-time bus tracking system using Flutter  
2. Implement **login/signup** for drivers & students  
3. Show **driver’s live location** on Google Maps  
4. Update & fetch **location data from Firebase**  
5. Provide **separate dashboard pages** for drivers & students  

---

## 📂 Code Structure  

```

RealTimeBusTracker/
└── lib/
├── main.dart            # App entry point
├── models/              # User & Location models
├── pages/               # Login, Signup, StudentPage, DriverPage
├── services/            # Firebase + Google Maps integration
├── widgets/             # Reusable UI components

````

---

## 📦 Modules Overview  

### Main.dart  
- App entry point  
- Handles routes & authentication state  

### Pages  
- **LoginPage** – User login (Driver / Student selection)  
- **SignupPage** – Registration for students & drivers  
- **DriverPage** –  
  - Driver logs in and shares real-time bus location  
  - Location updates stored in Firebase  
- **StudentPage** –  
  - Students log in and view **Google Map** with driver’s location marker  

### Services  
- **AuthService** – Firebase login/signup  
- **LocationService** – Gets live GPS location  
- **FirestoreService** – Stores & fetches driver location  

### Models  
- **UserModel** – Student/Driver details  
- **LocationModel** – Latitude, Longitude, Timestamp  

---

## 🔥 Firebase Output  

- Users stored in Firebase Authentication (student/driver roles) ✅  
- Driver’s live location stored in Firestore ✅  
- Students fetch driver’s location in real time ✅  

*(Add Firebase console screenshots here)*  

---

## ✅ Conclusion  

This project demonstrates how **real-time tracking apps** can be built with Flutter, Firebase, and Google Maps API.  
It provides a **student-friendly** and **driver-friendly** system for bus location tracking.  

---

## 👨‍💻 Authors  

- **Shayan Adil Khan** – Driver/Student modules & integration  
---

## ⭐ Future Enhancements  

- [ ] Multiple drivers/buses on map  
- [ ] Notifications for bus arrival  
- [ ] Estimated Time of Arrival (ETA)  
- [ ] Bus route display on Google Maps  
- [ ] Offline mode for drivers  

---

## 📌 How to Run  

1. Clone the repo:  
   ```bash
   git clone https://github.com/YourUsername/RealTimeBusTracker.git
   cd RealTimeBusTracker
````

2. Install dependencies:

   ```bash
   flutter pub get
   ```
3. Add your **Google Maps API Key** in `AndroidManifest.xml` and `AppDelegate.swift`.
4. Run the app:

   ```bash
   flutter run
   ```

---

📢 *If you like this project, give it a ⭐ on GitHub!*

```
