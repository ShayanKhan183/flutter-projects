import 'package:flutter/material.dart';

/*
  If (no options is chosen)
    all answer cards should have default style
    all buttons should be enabled
  else
    all button should be disabled
    if (correct option is chosen)
      answer should be highlighted as green
    else
      answer should be highlighted as red
      correct answer should be highlighted as green
*/

class AnswerCard extends StatelessWidget {
  const AnswerCard({
    super.key,
    required this.question,
    required this.isSelected,
    required this.currentIndex,
    required this.correctAnswerIndex,
    required this.selectedAnswerIndex,
  });

  final String question;
  final bool isSelected;
  final int? correctAnswerIndex;
  final int? selectedAnswerIndex;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    bool isCorrectAnswer = currentIndex == correctAnswerIndex;
    bool isWrongAnswer = !isCorrectAnswer && isSelected;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: 70,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white, // background white
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selectedAnswerIndex != null
                ? (isCorrectAnswer
                ? Colors.green
                : isWrongAnswer
                ? Colors.red
                : Colors.grey.shade300)
                : Colors.grey.shade300,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                question,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black, // text black
                ),
              ),
            ),
            const SizedBox(width: 10),
            if (selectedAnswerIndex != null)
              (isCorrectAnswer
                  ? buildCorrectIcon()
                  : isWrongAnswer
                  ? buildWrongIcon()
                  : const SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}

Widget buildCorrectIcon() => const CircleAvatar(
  radius: 15,
  backgroundColor: Colors.green,
  child: Icon(
    Icons.check,
    color: Colors.white,
  ),
);

Widget buildWrongIcon() => const CircleAvatar(
  radius: 15,
  backgroundColor: Colors.red,
  child: Icon(
    Icons.close,
    color: Colors.white,
  ),
);
