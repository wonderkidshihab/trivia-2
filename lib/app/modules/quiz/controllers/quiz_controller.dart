import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trivia/app/data/models/question_model.dart';
import 'package:trivia/app/data/repositories/question_repository.dart';
import 'package:trivia/app/routes/app_pages.dart';

class QuizController extends GetxController
    with StateMixin<List<QuestionModel>> {
  final QuestionRepository _questionRepository = QuestionRepository();

  PageController pageController = PageController();
  RxList<bool> answers = <bool>[].obs;

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    fetchQuestions();
    super.onInit();
  }

  Future<void> fetchQuestions() async {
    List<QuestionModel> questions = await _questionRepository.getQuestions();
    change(questions, status: RxStatus.success());
  }

  void next({required bool answer}) {
    answers.add(answer);
    if (pageController.page!.toInt() == state!.length - 1) {
      Get.toNamed(Routes.GAMEOVER, arguments: answers);
      return;
    }
    pageController.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }
}
