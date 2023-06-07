import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trivia/app/theme/app_theme.dart';

import 'app/routes/app_pages.dart';
late FragmentProgram fragmentProgram;
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  fragmentProgram = await FragmentProgram.fromAsset("assets/shaders/new.frag");
  await GetStorage.init();
  runApp(
    GetMaterialApp(
      title: "Trivia Quiz",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme(),
    ),
  );
}
