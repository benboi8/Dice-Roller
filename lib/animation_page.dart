import 'dart:async';

import 'package:flutter/material.dart';

import 'settings.dart';

class AnimationState {
  static double turns = 0.0;
  static double get turnChange => Settings.fastAnimations ? 0.5 : 2;

  static double scale = 1;
  static double get scaleChange => Settings.fastAnimations ? 0.75 : 0.6;
  // in seconds
  static Duration get animationDuration => Settings.fastAnimations ? const Duration(milliseconds: 500) : const Duration(seconds: 2);
  static Duration get animationDurationHalved => Settings.fastAnimations ? const Duration(milliseconds: 250) : const Duration(seconds: 1);
  static bool animating = false;

  static Future<bool> startAnimation() {
    startAnimating();

    return Future.delayed(animationDuration, () => true);
  }

  static void startAnimating() {
    if (!animating) {
      turns += turnChange;
      scale = scaleChange;
      animating = true;
      Future.delayed(animationDuration, () {
        animating = false;
      });
      Future.delayed(animationDurationHalved, () {
        scale = 1;
      });
    }
  }

  static const AnimateDice animation = AnimateDice();
  static Widget? face;

  static Widget animate(Widget child) {
    face = child;

    return animation;
  }
}

class AnimateDice extends StatefulWidget {
  const AnimateDice({super.key});

  @override
  State<AnimateDice> createState() => _AnimateDiceState();
}

class _AnimateDiceState extends State<AnimateDice> {
  late Timer timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
        duration: AnimationState.animationDurationHalved,
        scale: AnimationState.scale,
        curve: Curves.easeOut,
        child: AnimatedRotation(
          turns: AnimationState.turns,
          duration: AnimationState.animationDuration,
          child: AnimationState.face ?? Container()
        ),
    );
  }
}
