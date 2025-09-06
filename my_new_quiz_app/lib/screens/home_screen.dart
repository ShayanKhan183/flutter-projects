import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/screens/quiz_category_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void logout() async {
    await FirebaseAuth.instance.signOut();
    // No need to navigate manually — StreamBuilder in main.dart will handle redirect
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: logout,
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/images/home_bg.png',
            fit: BoxFit.cover,
          ),
          // Overlay
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          // Content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/quiz_logo.jpg',
                    height: 200,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Welcome to Quiz App!',
                    style: GoogleFonts.poppins(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'This is a Quiz App.\nClick Start to choose a quiz and test your skills!',
                    style: GoogleFonts.openSans(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                      backgroundColor: Colors.blueAccent,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const QuizCategoryScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Start Quiz',
                      style: GoogleFonts.roboto(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
