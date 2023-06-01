// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class QuestionModel {
  final String? question;
  final String? correctAnswer;
  final List<String> answers;
  QuestionModel({
    this.question,
    this.correctAnswer,
    required this.answers,
  });

  QuestionModel copyWith({
    String? question,
    String? correctAnswer,
    List<String>? answers,
  }) {
    return QuestionModel(
      question: question ?? this.question,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      answers: answers ?? this.answers,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'question': question,
      'correct_answer': correctAnswer,
      'incorrect_answers': answers,
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    var questionModel =  QuestionModel(
      question: map['question'] as String?,
      correctAnswer: map['correct_answer'] as String?,
      answers: List<String>.from(map['incorrect_answers'] as List<dynamic>),
    );
    questionModel.answers.add(questionModel.correctAnswer!);
    questionModel.answers.shuffle();
    return questionModel;
  }

  String toJson() => json.encode(toMap());

  factory QuestionModel.fromJson(String source) =>
      QuestionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'QuestionModel(question: $question, correctAnswer: $correctAnswer, answers: $answers)';

  @override
  bool operator ==(covariant QuestionModel other) {
    if (identical(this, other)) return true;

    return other.question == question &&
        other.correctAnswer == correctAnswer &&
        listEquals(other.answers, answers);
  }

  @override
  int get hashCode =>
      question.hashCode ^ correctAnswer.hashCode ^ answers.hashCode;
}
