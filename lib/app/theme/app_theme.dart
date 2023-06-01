import 'package:flutter/material.dart';

class AppTheme {
  static theme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.amber,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
      ),
    );
  }
}
