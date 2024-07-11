import 'dart:ui' as ui;

import 'package:flutter/material.dart';

//Add this CustomPaint widget to the Widget Tree
// CustomPaint(
//     size: Size(WIDTH, (WIDTH*0.5435897435897435).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
//     painter: RPSCustomPainter(),
// )

//Copy this CustomPainter code to the Bottom of the File
class LoginAdminShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.8034198);
    path_0.lineTo(size.width * 0.02307692, size.height * 0.7350425);
    path_0.cubicTo(
        size.width * 0.04871795,
        size.height * 0.6666651,
        size.width * 0.09487179,
        size.height * 0.5299151,
        size.width * 0.1435897,
        size.height * 0.5128208);
    path_0.cubicTo(
        size.width * 0.1897436,
        size.height * 0.5042736,
        size.width * 0.2384615,
        size.height * 0.5982925,
        size.width * 0.2846154,
        size.height * 0.6153868);
    path_0.cubicTo(
        size.width * 0.3333333,
        size.height * 0.6324764,
        size.width * 0.3820513,
        size.height * 0.5641038,
        size.width * 0.4282051,
        size.height * 0.5299151);
    path_0.cubicTo(
        size.width * 0.4769231,
        size.height * 0.5042736,
        size.width * 0.5230769,
        size.height * 0.5042736,
        size.width * 0.5717949,
        size.height * 0.5470094);
    path_0.cubicTo(
        size.width * 0.6179487,
        size.height * 0.5982925,
        size.width * 0.6666667,
        size.height * 0.7008538,
        size.width * 0.7153846,
        size.height * 0.7008538);
    path_0.cubicTo(
        size.width * 0.7615385,
        size.height * 0.7008538,
        size.width * 0.8102564,
        size.height * 0.5982925,
        size.width * 0.8564103,
        size.height * 0.4700854);
    path_0.cubicTo(
        size.width * 0.9051282,
        size.height * 0.3333335,
        size.width * 0.9512821,
        size.height * 0.1709401,
        size.width * 0.9769231,
        size.height * 0.08547028);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(size.width * 0.9769231, size.height);
    path_0.cubicTo(size.width * 0.9512821, size.height, size.width * 0.9051282,
        size.height, size.width * 0.8564103, size.height);
    path_0.cubicTo(size.width * 0.8102564, size.height, size.width * 0.7615385,
        size.height, size.width * 0.7153846, size.height);
    path_0.cubicTo(size.width * 0.6666667, size.height, size.width * 0.6179487,
        size.height, size.width * 0.5717949, size.height);
    path_0.cubicTo(size.width * 0.5230769, size.height, size.width * 0.4769231,
        size.height, size.width * 0.4282051, size.height);
    path_0.cubicTo(size.width * 0.3820513, size.height, size.width * 0.3333333,
        size.height, size.width * 0.2846154, size.height);
    path_0.cubicTo(size.width * 0.2384615, size.height, size.width * 0.1897436,
        size.height, size.width * 0.1435897, size.height);
    path_0.cubicTo(
        size.width * 0.09487179,
        size.height,
        size.width * 0.04871795,
        size.height,
        size.width * 0.02307692,
        size.height);
    path_0.lineTo(0, size.height);
    path_0.lineTo(0, size.height * 0.8034198);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xff0099FF).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
