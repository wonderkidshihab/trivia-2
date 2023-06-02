import 'package:get/get.dart';

class GameoverController extends GetxController {
  final score = 0.obs;
  
  @override
  void onInit() {
    super.onInit();

    score.value = Get.arguments;
  }
}
