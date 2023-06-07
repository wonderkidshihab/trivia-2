import 'package:get/get.dart';

import '../controllers/shader_controller.dart';

class ShaderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShaderController>(
      () => ShaderController(),
    );
  }
}
