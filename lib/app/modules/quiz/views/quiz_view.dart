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
      appBar: AppBar(title: const Text('Quiz')),
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

      /// A bottombar to show a stepper for how many questions have been answered
      bottomNavigationBar: controller.obx(
        (state) {
          return Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 0),
                ),
              ],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                controller.state!.length,
                (index) => Obx(
                  () => Container(
                    margin: const EdgeInsets.all(5),
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      color: controller.answers.length > index
                          ? controller.answers[index]
                              ? Colors.green
                              : Colors.red
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        onLoading: const SizedBox.shrink(),
        onEmpty: const SizedBox.shrink(),
      ),
    );
  }
}
