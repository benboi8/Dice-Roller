import 'dart:async';

import 'package:flutter/material.dart';

import 'accents.dart';
import 'dice.dart';
import 'roller.dart';
import 'settings.dart';
import 'preference_manager.dart';

void main() {
  runApp(const HomePage());
}

Color invertColor({required Color color, alpha = 255}) {
  return Color.fromARGB(
      alpha, 255 - color.red, 255 - color.green, 255 - color.blue);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Timer timer;

  @override
  void initState() {
    super.initState();

    PreferenceManager.getInstance();

    Dice(Settings.sides);

    timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      if (mounted) {
        if (Settings.selectedAccent != currentAccent) {
          setState(() {
            currentAccent = Settings.selectedAccent;
          });
        }
        if (Settings.brightness != currentBrightness) {
          setState(() {
            currentBrightness = Settings.brightness;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    timer.cancel();
  }

  int currentAccent = Settings.selectedAccent;
  Brightness currentBrightness = Settings.brightness;

  @override
  Widget build(BuildContext context) {

    AccentColor accentColor = Settings.accentColor;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true, brightness: Settings.brightness)
            .copyWith(
                appBarTheme: AppBarTheme(
                    backgroundColor: accentColor.main,
                    centerTitle: true,
                    foregroundColor: accentColor.secondary,
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: accentColor.tertiary,
                    foregroundColor: accentColor.secondary),
                elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => accentColor.main),
                        foregroundColor: MaterialStateColor.resolveWith(
                            (states) => accentColor.secondary))),
                sliderTheme: SliderThemeData(
                  activeTrackColor: accentColor.tertiary,
                  activeTickMarkColor: accentColor.secondary,
                  thumbColor: accentColor.main
                ),
                switchTheme: SwitchThemeData(
                  trackColor: MaterialStateColor.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return accentColor.tertiary;
                    } else {
                      return accentColor.secondary;
                    }
                  }),
                  thumbColor: MaterialStateColor.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return accentColor.main;
                    } else {
                      return accentColor.tertiary;
                    }
                  }),
                )
        ),
        home: const RollerPage());
  }
}
