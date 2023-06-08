import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:trivia/main.dart';

class ShaderView extends StatefulWidget {
  final double speedOfCloud;
  final double sizeOfCloud;
  final Color cloudColor;
  const ShaderView(
      {Key? key, this.sizeOfCloud = 5000, this.speedOfCloud = 0.01, this.cloudColor = Colors.blue})
      : super(key: key);

  @override
  State<ShaderView> createState() => _ShaderViewState();
}

class _ShaderViewState extends State<ShaderView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double time = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, reverseDuration: const Duration(seconds: 5))
      ..repeat(period: const Duration(seconds: 5), reverse: true)
      ..addListener(() {
        setState(() {
          time += widget.speedOfCloud;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: MyPainter(
              color: widget.cloudColor,
              shader: fragmentProgram.fragmentShader(),
              time: time,
              sizeOfCloud: widget.sizeOfCloud,
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
  final double time;
  final double sizeOfCloud;
  const MyPainter(
      {this.color = Colors.blue,
      required this.shader,
      required this.time,
      required this.sizeOfCloud});

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, size.width); // uSize
    shader.setFloat(1, size.height); // uSize
    shader.setFloat(2, color.red.toDouble() / 255); // uColor.r
    shader.setFloat(3, color.green.toDouble() / 255); // uColor.g
    shader.setFloat(4, color.blue.toDouble() / 255); // uColor.b
    shader.setFloat(5, color.opacity); // uColor.a
    shader.setFloat(6, time); // uSpeed
    shader.setFloat(7, 1 / sizeOfCloud); // uCloudSize
    final paint = Paint();
    paint.shader = shader;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) {
    return oldDelegate.time != time;
  }
}
