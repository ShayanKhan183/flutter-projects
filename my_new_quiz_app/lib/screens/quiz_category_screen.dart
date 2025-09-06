import 'package:flutter/material.dart';
import '/screens/quiz_screen.dart';
import '/models/question.dart';

// Example lists — replace with your actual files later
import '/models/general_knowledge_questions.dart';
import '/models/math_questions.dart';
import '/models/computer_questions.dart';

class QuizCategoryScreen extends StatelessWidget {
  const QuizCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Quiz Category'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/home_bg.png',
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.white.withOpacity(0.8),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min, // only take needed height
                crossAxisAlignment: CrossAxisAlignment.stretch, // buttons full width
                children: [
                  Text(
                    'Select a quiz category to get started:',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[900],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  _buildCategoryButton(
                    context,
                    label: 'General Knowledge Quiz',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              QuizScreen(questions: generalKnowledgeQuestions),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  _buildCategoryButton(
                    context,
                    label: 'Math Quiz',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => QuizScreen(questions: mathQuestions),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  _buildCategoryButton(
                    context,
                    label: 'Computer Quiz',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              QuizScreen(questions: computerQuestions),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(
      BuildContext context, {
        required String label,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      splashColor: Colors.blueAccent.withOpacity(0.3),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.4),
              offset: const Offset(0, 4),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.1,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
