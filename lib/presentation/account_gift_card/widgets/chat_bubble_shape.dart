import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class ChatBubbleShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.shader = ui.Gradient.linear(
        Offset(0, size.height * 0.5000000),
        Offset(size.width * 0.9623431, size.height * 0.5000000),
        [Color(0xff9DFF9D).withOpacity(1), Color(0xffE6FF82).withOpacity(1)],
        [0, 1]);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
            Rect.fromLTWH(0, 0, size.width * 0.9623431, size.height),
            bottomRight: Radius.circular(size.width * 0.01673640),
            bottomLeft: Radius.circular(size.width * 0.01673640),
            topLeft: Radius.circular(size.width * 0.01673640),
            topRight: Radius.circular(size.width * 0.01673640)),
        paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.9978285, size.height * 0.7474654);
    path_1.lineTo(size.width * 0.9540377, size.height * 0.8624673);
    path_1.cubicTo(
        size.width * 0.9488243,
        size.height * 0.8761635,
        size.width * 0.9456067,
        size.height * 0.9016519,
        size.width * 0.9456067,
        size.height * 0.9292558);
    path_1.lineTo(size.width * 0.9456067, size.height * 0.9615385);
    path_1.lineTo(size.width * 0.9163180, size.height * 0.9615385);
    path_1.lineTo(size.width * 0.9163180, size.height * 0.5000000);
    path_1.lineTo(size.width * 0.9456067, size.height * 0.5000000);
    path_1.lineTo(size.width * 0.9456067, size.height * 0.5322827);
    path_1.cubicTo(
        size.width * 0.9456067,
        size.height * 0.5598865,
        size.width * 0.9488243,
        size.height * 0.5853750,
        size.width * 0.9540377,
        size.height * 0.5990712);
    path_1.lineTo(size.width * 0.9978285, size.height * 0.7140731);
    path_1.cubicTo(
        size.width * 1.000636,
        size.height * 0.7214558,
        size.width * 1.000636,
        size.height * 0.7400827,
        size.width * 0.9978285,
        size.height * 0.7474654);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = Color(0xffE4FF83).withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
