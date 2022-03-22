import 'package:amalia_musica/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';

class LineaHorizontal extends CustomPainter {
  late Paint _paint;

  LineaHorizontal() {
    _paint = Paint()
      ..color = AppColors.grisBase
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(const Offset(-70.0, 0.0), const Offset(70.0, 0.0), _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
