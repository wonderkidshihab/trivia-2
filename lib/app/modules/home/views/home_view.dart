import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trivia/app/modules/shader/views/shader_view.dart';
import 'package:trivia/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => Positioned.fill(
              child: ShaderView(
                sizeOfCloud: controller.sizeOfCloud.value.toDouble(),
                speedOfCloud: controller.speedOfCloud.value.toDouble(),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: double.infinity),
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  "assets/images/logo.jpg",
                  height: 200,
                  width: 200,
                ),
              ),
              const SizedBox(height: 20),
              const Text("Trivia Quiz", style: TextStyle(fontSize: 30)),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () => Get.toNamed(Routes.QUIZ),
                child: const Text("Start Quiz"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Get.toNamed(Routes.HISTORY),
                child: const Text("History"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Get.toNamed(Routes.SHADER),
                child: const Text("Shader"),
              ),
              const SizedBox(height: 20),
              Obx(
                () => Slider(
                    value: controller.sizeOfCloud.value.toDouble(),
                    min: 100,
                    max: 1000,
                    onChanged: (value) {
                      controller.sizeOfCloud.value = value.toInt();
                    }),
              ),
              const SizedBox(height: 20),
              Obx(
                () => Slider(
                    value: controller.speedOfCloud.value.toDouble(),
                    onChanged: (value) {
                      controller.speedOfCloud.value = value;
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
