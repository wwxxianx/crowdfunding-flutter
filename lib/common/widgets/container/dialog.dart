import 'package:flutter/material.dart';
import 'dart:ui' as ui;

extension ShowDialogExtension on BuildContext {
  void displayDialog({
    EdgeInsetsGeometry padding = const EdgeInsets.only(
      top: 35.0,
      bottom: 20.0,
      left: 20.0,
      right: 20.0,
    ),
    required Widget child,
  }) {
    showDialog<String>(
      context: this,
      builder: (BuildContext context) => Dialog(
        backgroundColor: Colors.white,
        child: IntrinsicHeight(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
            ),
            clipBehavior: Clip.hardEdge,
            // width: 400,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                CustomPaint(
                  size: Size(322, 262),
                  painter: DialogGradientShapePainter(),
                ),
                Padding(
                  padding: padding,
                  child: child,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DialogGradientShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.shader = ui.Gradient.linear(
      Offset(size.width * 0.1612031, size.height * 0.1113966),
      Offset(size.width * 0.2113084, size.height * 0.4355229),
      [Color(0xff41FB9E).withOpacity(0.45), Colors.white.withOpacity(0)],
      [0, 1],
    );
    paint_0_fill.maskFilter = const MaskFilter.blur(BlurStyle.normal, 260);
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(size.width * 0.09937888, size.height * 0.1889313),
            width: size.width * 0.2670807,
            height: size.height * 0.4007634),
        paint_0_fill);

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    canvas.rotate(-57);
    paint_1_fill.maskFilter = const MaskFilter.blur(BlurStyle.normal, 160);
    paint_1_fill.color = Color(0xffECFFB7).withOpacity(1.0);
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(size.width * 0.4897112, size.height * -0.04862061),
            width: size.width * 0.5604677,
            height: size.height * 1.115046),
        paint_1_fill);
    canvas.rotate(0);

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.maskFilter = const MaskFilter.blur(BlurStyle.normal, 100);
    paint_2_fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.8672640, size.height * 0.07339580),
        Offset(size.width * 1.200298, size.height * 0.1339038), [
      Color(0xffFDA442).withOpacity(1),
      Color(0xffA9D849).withOpacity(1),
    ], [
      0,
      1
    ]);
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(size.width * 0.9187453, size.height * 0.1319042),
            width: size.width * 0.4770242,
            height: size.height * 0.3607794),
        paint_2_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
