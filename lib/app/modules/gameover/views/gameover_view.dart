import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/gameover_controller.dart';

class GameoverView extends GetView<GameoverController> {
  const GameoverView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GameoverView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'GameoverView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
