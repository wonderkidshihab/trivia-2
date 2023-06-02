import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trivia/app/routes/app_pages.dart';

import '../controllers/gameover_controller.dart';

class GameoverView extends GetView<GameoverController> {
  const GameoverView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'You have finished the quiz!',
            style: TextStyle(fontSize: 28),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Your final Score:',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            '${controller.score.value}',
            style: const TextStyle(fontSize: 34),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Get.offNamed(Routes.QUIZ);
                },
                label: const Text('Play Again'),
                icon: const Icon(Icons.replay),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Get.offNamed(Routes.HISTORY);
                },
                label: const Text('View History'),
                icon: const Icon(Icons.history),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
