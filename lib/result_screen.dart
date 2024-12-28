import 'package:flutter/material.dart';
import 'package:quiz_1/data/questions.dart';
import 'package:quiz_1/question_summary/questions_summary.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(
      {super.key,
      required this.choosenAnswers,
      required this.restart,
      required this.exit});

  final List<String> choosenAnswers;
  final void Function() restart;
  final void Function() exit;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < choosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': choosenAnswers[i]
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalquestions = questions.length;
    final numCorrectQuestions = summaryData.where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You answered $numCorrectQuestions out of $numTotalquestions questions correctly',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            const SizedBox(
              height: 30,
            ),
            QuestionsSummary(getSummaryData()),
            const SizedBox(
              height: 30,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton.icon(
                    onPressed: restart,
                    label: Text(
                      'Restart Quiz',
                    ),
                    icon: Icon(Icons.refresh),
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromARGB(255, 1, 69, 4)),
                  ),
                  TextButton.icon(
                    onPressed: exit,
                    label: Text('Exit'),
                    icon: Icon(Icons.exit_to_app),
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromARGB(255, 1, 69, 4)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
