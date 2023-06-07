import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:trivia/main.dart';

class ShaderView extends StatefulWidget {
  const ShaderView({Key? key}) : super(key: key);

  @override
  State<ShaderView> createState() => _ShaderViewState();
}

class _ShaderViewState extends State<ShaderView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, reverseDuration: const Duration(seconds: 5))
      ..repeat(period: const Duration(seconds: 5), reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: MyPainter(
              color: Colors.blue,
              shader: fragmentProgram.fragmentShader(),
              value: _controller.value,
            ),
            child: Container(),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class MyPainter extends CustomPainter {
  final Color color;
  final FragmentShader shader;
  final double value;
  const MyPainter(
      {this.color = Colors.blue, required this.shader, required this.value});

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    shader.setFloat(2, color.red.toDouble() / 255);
    shader.setFloat(3, color.green.toDouble() / 255);
    shader.setFloat(4, color.blue.toDouble() / 255);
    shader.setFloat(5, color.opacity);
    shader.setFloat(6, value);
    final paint = Paint();
    paint.shader = shader;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) {
    return oldDelegate.value != value;
  }
}
