import 'package:get/get.dart';

import '../controllers/gameover_controller.dart';

class GameoverBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GameoverController>(
      () => GameoverController(),
    );
  }
}
