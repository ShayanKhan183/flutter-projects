
# 📝 QuizMaster – Flutter Quiz App  

A **cross-platform Flutter application** where users can log in, select quiz categories, answer questions, and view their results.  
The app provides a simple yet engaging way to test knowledge across multiple subjects.  

---

## 📌 Project Documentation  

**Supervisor:** Mam Bakhtawar  
**Submitted By:**  
- Shayan Adil Khan (BCS-F22-E13)  

**Department of Computer Science, University of Mianwali, Punjab**  

---

## 🚀 Introduction  

QuizMaster is a **mobile quiz application** built using Flutter.  
It provides:  
- **Login & Signup system**  
- **Category-based quizzes** (Math, Science, History, etc.)  
- **Question navigation** with multiple-choice answers  
- **Result screen with score & percentage**  

---

## ❗ Problem Statement  

Many quiz apps are either too complex or limited to a single category.  
Students need a **lightweight, educational, and easy-to-use quiz app** with:  
- Secure login/signup  
- Multiple categories  
- Simple result evaluation  

---

## 🎯 Purpose / Solution  

QuizMaster provides:  
✅ Secure user login & signup  
✅ Organized subjects into categories  
✅ Randomized quizzes per subject  
✅ Final results showing **score, percentage, and correct answers**  

---

## 🛠️ Tools & Technologies  

- **Flutter** – Cross-platform UI toolkit  
- **Dart** – Programming language  
- **Firebase** – Authentication & Firestore (optional for results storage)  
- **Android Studio / VS Code** – IDEs  
- **GitHub** – Version control  

---

## 🎯 Key Objectives  

1. Develop a clean & simple **Quiz Application**  
2. Implement **Login/Signup authentication**  
3. Allow users to **choose categories** before starting a quiz  
4. Display **questions with multiple choices**  
5. Show **final results (marks, percentage, correct/incorrect answers)**  
6. Store progress (optional with Firebase)  

---

## 📂 Code Structure  

```

QuizApp/
└── lib/
├── main.dart            # App entry point
├── models/              # Data models for questions
├── pages/               # App screens (Login, Home, Quiz, Result)
├── widgets/             # Reusable UI components

````

---

## 📦 Modules Overview  

### Main.dart  
- Initializes app  
- Routes user to **LoginPage** or **HomePage**  

### Pages  
- **LoginPage** – User login  
- **SignupPage** – New user registration  
- **HomePage** – Welcome screen with quiz start option  
- **CategoryPage** – Subject categories (Math, Science, GK, etc.)  
- **QuizPage** – Displays multiple-choice questions  
- **ResultPage** – Shows score, percentage & performance summary  

### Models  
- **QuestionModel** – Question text, options, and correct answer  

### Widgets  
- **CustomButton** – Reusable button for quiz navigation  
- **OptionTile** – Displays each answer choice  
- **ResultCard** – Displays user score  

---

## 📱 Output (Screenshots)  

📌 *Add screenshots here:*  

- ![Login Page](assets/screenshots/login.png)  
- ![Signup Page](assets/screenshots/signup.png)  
- ![Home Page](assets/screenshots/home.png)  
- ![Category Selection](assets/screenshots/categories.png)  
- ![Quiz Page](assets/screenshots/quiz.png)  
- ![Result Page](assets/screenshots/result.png)  

---

## 🔥 Firebase Output (if integrated)  

- User Authentication ✅  
- Quiz results saved in Firestore ✅  

*(Add Firebase console screenshots here)*  

---

## ✅ Conclusion  

QuizMaster demonstrates how to build an **interactive quiz app** using Flutter with features like:  
- User login/signup  
- Multiple categories  
- Dynamic question handling  
- Score/result calculation  

---

## 👨‍💻 Authors  

- **Shayan Adil Khan** – Project Development  
---

## ⭐ Future Enhancements  

- [ ] Timer-based quizzes  
- [ ] Leaderboards  
- [ ] Save progress for each user  
- [ ] Add images in questions  
- [ ] Dark mode support  

---

## 📌 How to Run  

1. Clone the repo:  
   ```bash
   git clone https://github.com/YourUsername/QuizApp.git
   cd QuizApp
````

2. Install dependencies:

   ```bash
   flutter pub get
   ```
3. Run the app:

   ```bash
   flutter run
   ```

---

📢 *If you like this project, give it a ⭐ on GitHub!*

```
