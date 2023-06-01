import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trivia/app/data/models/question_model.dart';
import 'package:trivia/app/modules/quiz/controllers/quiz_controller.dart';

/// This widget is used to display a single question with the multiple choices(4) as the possible answers.
/// This widget is used in the QuizView
class QuestionWidget extends StatefulWidget {
  const QuestionWidget({super.key, required this.question});
  final QuestionModel question;

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  String? selectedAnswer;
  final QuizController quizController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Theme.of(context).primaryColor),
          ),
          constraints: const BoxConstraints(maxWidth: 500, maxHeight: 300),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.question.question ?? "N/A",
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.center,
                runSpacing: 10,
                spacing: 10,
                children: widget.question.answers
                    .map(
                      (answer) => ChoiceChip(
                        label: Text(answer),
                        selected: selectedAnswer == answer,
                        onSelected: (value) {
                          setState(() {
                            if (answer == selectedAnswer) {
                              selectedAnswer = null;
                            } else {
                              selectedAnswer = answer;
                            }
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: selectedAnswer == null
              ? null
              : () {
                  if (selectedAnswer == widget.question.correctAnswer) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Correct Answer"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Wrong Answer"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
          child: const Text("Submit"),
        ),
      ],
    );
  }
}
