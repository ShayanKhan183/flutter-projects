import 'package:flutter/material.dart';

import '/models/question.dart';
import '/screens/result_screen.dart';
import '/widgets/answer_card.dart';
import '/widgets/next_button.dart';

class QuizScreen extends StatefulWidget {
  final List<Question> questions;
  final String? title; // Optional quiz title for the AppBar

  const QuizScreen({
    super.key,
    required this.questions,
    this.title,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int? selectedAnswerIndex;
  int questionIndex = 0;
  int score = 0;

  void pickAnswer(int value) {
    selectedAnswerIndex = value;
    final question = widget.questions[questionIndex];
    if (selectedAnswerIndex == question.correctAnswerIndex) {
      score++;
    }
    setState(() {});
  }

  void goToNextQuestion() {
    if (questionIndex < widget.questions.length - 1) {
      questionIndex++;
      selectedAnswerIndex = null;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[questionIndex];
    bool isLastQuestion = questionIndex == widget.questions.length - 1;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.title ?? 'Quiz App',
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/home_bg.png',
            fit: BoxFit.cover,
          ),
          // Optional overlay
          Container(
            color: Colors.white.withOpacity(0.8),
          ),
          // Quiz content
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  question.question,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: question.options.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: selectedAnswerIndex == null
                            ? () => pickAnswer(index)
                            : null,
                        child: AnswerCard(
                          currentIndex: index,
                          question: question.options[index],
                          isSelected: selectedAnswerIndex == index,
                          selectedAnswerIndex: selectedAnswerIndex,
                          correctAnswerIndex: question.correctAnswerIndex,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                isLastQuestion
                    ? RectangularButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => ResultScreen(
                          score: score,
                          totalQuestions: widget.questions.length, // Required param
                        ),
                      ),
                    );
                  },
                  label: 'Finish',
                )
                    : RectangularButton(
                  onPressed:
                  selectedAnswerIndex != null ? goToNextQuestion : null,
                  label: 'Next',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
