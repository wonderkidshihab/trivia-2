import 'package:get/get.dart';
import 'package:trivia/app/data/models/history_model.dart';
import 'package:trivia/app/data/repositories/history_repository.dart';

class HistoryController extends GetxController
    with StateMixin<List<HistoryModel>> {
  final HistoryRepository _historyRepository = HistoryRepository();

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    fetchHistory();
    super.onInit();
  }

  Future<void> fetchHistory() async {
    List<HistoryModel> history = await _historyRepository.getHistory();
    if (history.isEmpty) {
      change([], status: RxStatus.empty());
    } else {
      change(history, status: RxStatus.success());
    }
  }
}
