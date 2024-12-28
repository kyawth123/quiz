import 'package:flutter/material.dart';
import 'package:quiz_1/data/questions.dart';
import 'package:quiz_1/questions_screen.dart';
import 'package:quiz_1/result_screen.dart';
import 'package:quiz_1/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
// Widget? activeScreen;

// @override
// void initState() {
//   activeScreen = StartScreen(switchScreen);
//   super.initState();
// }
  List<String> selectedAnswers = [];
  var activeScreen = 'start-screen';

  void switchScreen() {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      setState(() {
        // selectedAnswers = [];
        activeScreen = 'results-screen';
      });
    }
  }

  void resetQuestion() {
    setState(() {
      selectedAnswers = [];
      activeScreen = 'questions-screen';
    });
  }

  void exit() {
    setState(() {
      selectedAnswers = [];
      activeScreen = 'start-screen';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = StartScreen(switchScreen);

    if (activeScreen == 'questions-screen') {
      screenWidget = QuestionsScreen(
        onSelectAnswer: chooseAnswer,
      );
    }

    if (activeScreen == 'results-screen') {
      screenWidget = ResultScreen(
        choosenAnswers: selectedAnswers,
        restart: resetQuestion,
        exit: exit,
      );
    }
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(
                      255, 3, 7, 4), // Adjusted opacity for visibility
                  Color.fromARGB(255, 50, 100, 70), // Added a second color
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            // child: activeScreen,
            child: screenWidget,
          ),
        ));
  }
}
