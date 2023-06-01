import 'package:get/get.dart';
import 'package:trivia/app/data/models/question_model.dart';

class QuestionRepository extends GetConnect {
  QuestionRepository() {
    baseUrl = "https://opentdb.com/";
    defaultContentType = "application/json";
  }

  Future<List<QuestionModel>> getQuestions() async {
    final response = await get("api.php", query: {
      "amount": "10",
      "type": "multiple",
      "difficulty": "easy",
    });
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      final questions = response.body["results"] as List;
      return questions.map((e) => QuestionModel.fromMap(e)).toList();
    }
  }
}
