import 'package:awesome_dialog/awesome_dialog.dart';
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
    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Theme.of(context).primaryColor),
          ),
          constraints: const BoxConstraints(maxWidth: 500, maxHeight: 400),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.question.question ?? "N/A",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.center,
                runSpacing: 10,
                spacing: 10,
                children: widget.question.answers
                    .map(
                      (answer) => Draggable<String>(
                        feedback: Material(child: Chip(label: Text(answer))),
                        data: answer,
                        childWhenDragging: Chip(label: Text(answer)),
                        child: Chip(label: Text(answer)),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: DragTarget<String>(
            builder: (context, candidateData, rejectedData) {
              return Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 50),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                ),
                child: Text(
                  selectedAnswer ?? "Drag your answer here",
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              );
            },
            onWillAccept: (data) {
              return true;
            },
            onAccept: (data) {
              setState(() {
                selectedAnswer = data;
              });
            },
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: selectedAnswer == null
                ? null
                : () async {
                    if (selectedAnswer == widget.question.correctAnswer) {
                      await AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        title: "Correct Answer",
                        desc: "You got it right!",
                        autoDismiss: true,
                        dismissOnTouchOutside: true,
                        dismissOnBackKeyPress: true,
                        animType: AnimType.bottomSlide,
                        autoHide: const Duration(seconds: 1),
                      ).show();
                      quizController.next(answer: true);
                    } else {
                      await AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        title: "Wrong Answer",
                        desc: "You got it wrong!",
                        autoDismiss: true,
                        dismissOnTouchOutside: true,
                        dismissOnBackKeyPress: true,
                        animType: AnimType.bottomSlide,
                        autoHide: const Duration(seconds: 1),
                      ).show();
                      quizController.next(answer: false);
                    }
                  },
            child: const Text("Submit"),
          ),
        ),
      ],
    );
  }
}
