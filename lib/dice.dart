import 'dart:math';

import 'package:flutter/material.dart';

import 'dice_style.dart';

class Dice {
  static final List<Dice> _dices = [];

  late int number;
  late DateTime _timeRolled;
  int sides = 6;

  String get time => "${_timeRolled.hour % 12}:${_timeRolled.minute} ${_timeRolled.hour <= 12 ? 'AM' : 'PM'}";

  Dice(this.sides) {
    number = Random(DateTime.now().millisecondsSinceEpoch).nextInt(sides) + 1;
    _timeRolled = DateTime.now();
    _dices.add(this);
  }

  static Dice getHistory(int index) => _dices[length - index - 1];

  static Dice getIndex(int index) {
    return _dices.elementAt(length - 1 - index);
  }

  static Dice getLatest() {
    return _dices.last;
  }

  static int get length => _dices.length;

  Widget getFace() {
    DiceFacePaint paint = DiceFacePaint(this);
    if (paint.canPaint()) {
      return SizedBox(
        width: DiceStyler.width,
        height: DiceStyler.height,
        child: CustomPaint(
            size: Size(DiceStyler.width, DiceStyler.height),
            painter: paint
        ),
      );
    } else {
      return SizedBox(
        width: DiceStyler.width,
        height: DiceStyler.height,
        child: DecoratedBox(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(DiceStyler.faceRadius))
            ),
            color: DiceStyler.faceColor
          ),
          child: Center(
            child: Text(
                Dice.length > 0 ? Dice.getLatest().number.toString() : "",
                style: TextStyle(
                    color: DiceStyler.dotColor,
                    fontSize: 100
                ),
            ),
          ),
        ),
      );
    }
  }
}

class DiceFacePaint extends CustomPainter{
  Dice dice;

  final double _dotRadius = 10;

  DiceFacePaint(this.dice);

  bool canPaint() {
    return dice.sides <= 9;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint face = Paint()
        ..color = DiceStyler.faceColor;

    Paint dot = Paint()
      .. color = DiceStyler.dotColor;

    Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: center, width: size.width, height: size.height), Radius.circular(DiceStyler.faceRadius)), face);

    switch (dice.number) {
      case 1:
        one(canvas, dot, size);
        break;
      case 2:
        two(canvas, dot, size);
        break;
      case 3:
        three(canvas, dot, size);
        break;
      case 4:
        four(canvas, dot, size);
        break;
      case 5:
        five(canvas, dot, size);
        break;
      case 6:
        six(canvas, dot, size);
        break;
      case 7:
        seven(canvas, dot, size);
        break;
      case 8:
        eight(canvas, dot, size);
        break;
      case 9:
        nine(canvas, dot, size);
        break;
    }
  }

  void one(Canvas canvas, Paint paint, Size size) {
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), _dotRadius, paint);
  }

  void two(Canvas canvas, Paint paint, Size size) {
    canvas.drawCircle(Offset(size.width / 3, size.height / 3), _dotRadius, paint);
    canvas.drawCircle(Offset(size.width / 1.5, size.height / 1.5), _dotRadius, paint);
  }

  void three(Canvas canvas, Paint paint, Size size) {
    one(canvas, paint, size);
    two(canvas, paint, size);
  }

  void four(Canvas canvas, Paint paint, Size size) {
    canvas.drawCircle(Offset(size.width / 1.5, size.height / 1.5), _dotRadius, paint);
    canvas.drawCircle(Offset(size.width / 1.5, size.height / 3), _dotRadius, paint);
    canvas.drawCircle(Offset(size.width / 3, size.height / 1.5), _dotRadius, paint);
    canvas.drawCircle(Offset(size.width / 3, size.height / 3), _dotRadius, paint);
  }

  void five(Canvas canvas, Paint paint, Size size) {
    one(canvas, paint, size);
    four(canvas, paint, size);
  }

  void six(Canvas canvas, Paint paint, Size size) {
    canvas.drawCircle(Offset(size.width / 3, size.height / 3), _dotRadius, paint);
    canvas.drawCircle(Offset(size.width / 3, size.height / 2), _dotRadius, paint);
    canvas.drawCircle(Offset(size.width / 3, size.height / 1.5), _dotRadius, paint);
    canvas.drawCircle(Offset(size.width / 1.5, size.height / 3), _dotRadius, paint);
    canvas.drawCircle(Offset(size.width / 1.5, size.height / 2), _dotRadius, paint);
    canvas.drawCircle(Offset(size.width / 1.5, size.height / 1.5), _dotRadius, paint);
  }

  void seven(Canvas canvas, Paint paint, Size size) {
    one(canvas, paint, size);
    six(canvas, paint, size);
  }

  void eight(Canvas canvas, Paint paint, Size size) {
    six(canvas, paint, size);
    canvas.drawCircle(Offset(size.width / 2, size.height / 3), _dotRadius, paint);
    canvas.drawCircle(Offset(size.width / 2, size.height / 1.5), _dotRadius, paint);
  }

  void nine(Canvas canvas, Paint paint, Size size) {
      eight(canvas, paint, size);
      one(canvas, paint, size);
  }




  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
