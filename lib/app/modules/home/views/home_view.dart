import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trivia/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: double.infinity),
          CircleAvatar(
            radius: 100,
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
        ],
      ),
    );
  }
}
