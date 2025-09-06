import 'package:flutter/material.dart';
import '/screens/quiz_category_screen.dart';
import '/widgets/next_button.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
  });

  final int score;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    double percentage = (score / totalQuestions) * 100;

    return Scaffold(
      // Make the body extend behind the app bar
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent app bar
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Result',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/home_bg.png', // Use your bg image path here
            fit: BoxFit.cover,
          ),
          // Semi-transparent overlay
          Container(
            color: Colors.black.withOpacity(0.6),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Your Score:',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 250,
                      width: 250,
                      child: CircularProgressIndicator(
                        strokeWidth: 12,
                        value: score / totalQuestions,
                        color: Colors.greenAccent,
                        backgroundColor: Colors.grey.shade700,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          score.toString(),
                          style: const TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${percentage.round()}%',
                          style: const TextStyle(
                            fontSize: 25,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // Button to go back to Categories
                RectangularButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => const QuizCategoryScreen(),
                      ),
                    );
                  },
                  label: 'Back to Categories',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
