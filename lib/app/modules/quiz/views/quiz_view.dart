import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trivia/app/data/models/question_model.dart';
import 'package:trivia/app/modules/quiz/views/question_widget.dart';

import '../controllers/quiz_controller.dart';

class QuizView extends GetView<QuizController> {
  const QuizView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QuizView')),
      body: controller.obx(
        (List<QuestionModel>? state) {
          return PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller.pageController,
            itemBuilder: (context, index) {
              return QuestionWidget(question: state[index]);
            },
            itemCount: state!.length,
          );
        },
      ),
    );
  }
}
