import 'package:flutter/material.dart';

import 'main.dart';
import 'settings.dart';
import 'string_consts.dart';

class DiceStyler {
  static double width = 200;
  static double height = 200;
  static double faceRadius = 30;

  static int colorIndex = 0;

  static Color get faceColor => colorCombinations.elementAt(colorIndex)[0];
  static Color get dotColor => colorCombinations.elementAt(colorIndex)[1];

  static final List<List<Color>> colorCombinations = [
    [Colors.white, Colors.black],
    [Colors.black, Colors.white],
    [Colors.white, Colors.red],
    [Colors.black, Colors.red],
    [Colors.white, Colors.blue],
    [Colors.black, Colors.blue],
    [Colors.white, Colors.green],
    [Colors.black, Colors.green],
  ];

  static List<Widget> getPaint(Color face, Color dot) {
    Size size = const Size(100, 50);
    return [
      CustomPaint(
        size: size,
        painter: DiceStylePaint(face, dot, 0),
      ),
      CustomPaint(size: size, painter: DiceStylePaint(face, dot, 1))
    ];
  }
}

class DiceStylePaint extends CustomPainter {
  Color face, dot;
  int index;

  DiceStylePaint(this.face, this.dot, this.index);

  final Radius _radius = const Radius.circular(20);

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);

    double width = size.width * 1.5;
    double height = size.height;

    if (index == 0) {
      Offset pos = Offset(size.width + 2, center.dy);

      Paint faceP = Paint()..color = face;
      Paint inverseFace = Paint()..color = invertColor(color: face, alpha: 75);

      canvas.drawRect(
        Rect.fromCenter(
            center: Offset((pos.dx - width / 4), pos.dy),
            width: width * 1.5,
            height: height * 1.4
        ),
        inverseFace,
      );

      canvas.drawRRect(
          RRect.fromRectAndCorners(
              Rect.fromCenter(
                  center: pos,
                  width: width,
                  height: height),
              topLeft: _radius,
              bottomLeft: _radius
          ),
          faceP);
    }

    if (index == 1) {
      Offset pos = Offset(-2, center.dy);

      Paint dotP = Paint()..color = dot;
      Paint inverseDot = Paint()..color = invertColor(color: dot, alpha: 75);

      canvas.drawRect(
        Rect.fromCenter(
            center: Offset((pos.dx + width / 4), pos.dy),
            width: width * 1.5,
            height: height * 1.4
        ),
        inverseDot
      );

      canvas.drawRRect(
          RRect.fromRectAndCorners(
              Rect.fromCenter(
                  center: pos,
                  width: width,
                  height: height),
            topRight: _radius,
            bottomRight: _radius
          ),
          dotP);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
