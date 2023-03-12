import 'package:flutter/material.dart';
import 'main.dart';

class ResultScreen extends StatefulWidget {
  final int score;
  const ResultScreen(this.score, {super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String resultMessage(int result) {
    if (result == 100) {
      return "Excellent";
    }
    if ((100 > result) && (result >= 90)) {
      return "Very Good";
    }
    if ((90 > result) && (result >= 70)) {
      return "Good";
    }
    if ((70 > result) && (result >= 50)) {
      return "Okey";
    }
    if (50 > result) {
      return "Failed";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    Color mainColor = const Color(0xFF252C4A);
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              resultMessage(widget.score),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 38.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Your Score",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 30.0),
            Text(
              "${widget.score}",
              style: const TextStyle(
                color: Colors.orange,
                fontSize: 80.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50.0),
            MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QuestionScreen(),
                  ),
                );
              },
              elevation: 0.0,
              color: Colors.orange,
              textColor: Colors.white,
              child: const Text(
                "Repeat the Quiz",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 22.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
