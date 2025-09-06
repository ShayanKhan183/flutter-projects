import 'package:flutter/material.dart';

class RectangularButton extends StatelessWidget {
  const RectangularButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  final VoidCallback? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: const TextStyle(
            letterSpacing: 1.5,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
