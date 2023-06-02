import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trivia/app/data/models/history_model.dart';
import 'package:trivia/app/data/models/question_model.dart';
import 'package:trivia/app/data/repositories/history_repository.dart';
import 'package:trivia/app/data/repositories/question_repository.dart';
import 'package:trivia/app/routes/app_pages.dart';
import 'package:uuid/uuid.dart';

class QuizController extends GetxController
    with StateMixin<List<QuestionModel>> {
  final QuestionRepository _questionRepository = QuestionRepository();
  final HistoryRepository _historyRepository = HistoryRepository();

  PageController pageController = PageController();
  RxList<bool> answers = <bool>[].obs;
  RxInt timer = 15.obs;

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    fetchQuestions();
    super.onInit();
  }

  Future<void> fetchQuestions() async {
    List<QuestionModel> questions = await _questionRepository.getQuestions();
    if (questions.isNotEmpty) {
      change(questions, status: RxStatus.success());
      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (this.timer.value == 0 && answers.length < state!.length) {
          next(answer: false);
        } else {
          this.timer.value = this.timer.value - 1;
        }
      });
    } else {
      change([], status: RxStatus.empty());
    }
  }

  void next({required bool answer}) {
    answers.add(answer);
    if (pageController.page!.toInt() == state!.length - 1) {
      _historyRepository.saveHistory(HistoryModel(
          id: const Uuid().v4(),
          score: answers.where((p0) => p0).length,
          date: DateTime.now()));
      Get.offNamed(Routes.GAMEOVER,
          arguments: answers.where((p0) => p0).length);
      return;
    }
    pageController.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
    timer.value = 15;
  }
}
