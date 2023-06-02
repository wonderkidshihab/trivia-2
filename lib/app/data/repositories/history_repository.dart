import 'package:get_storage/get_storage.dart';
import 'package:trivia/app/data/models/history_model.dart';

class HistoryRepository {
  Future<List<HistoryModel>> getHistory() async {
    GetStorage box = GetStorage("history");
    final List<HistoryModel> history = [];
    for (var item in box.getValues()) {
      history.add(HistoryModel.fromMap(item as Map<String, dynamic>));
    }
    return history;
  }

  Future<void> saveHistory(HistoryModel history) async {
    GetStorage box = GetStorage("history");
    await box.write(history.id.toString(), history.toMap());
  }

  Future<void> deleteHistory(int id) async {
    GetStorage box = GetStorage("history");
    await box.remove(id.toString());
  }
}
