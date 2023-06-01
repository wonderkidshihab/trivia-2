import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trivia/app/data/models/question_model.dart';
import 'package:trivia/app/data/repositories/question_repository.dart';

class QuizController extends GetxController
    with StateMixin<List<QuestionModel>> {
  final QuestionRepository _questionRepository = QuestionRepository();

  PageController pageController = PageController();

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
}
