import 'dart:async';

import 'package:dice_roller/setup.dart';
import 'package:dice_roller/string_consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

void routeToMainPage(BuildContext context, page, bool isLeft) {
  Navigator.of(context).push(PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: const Duration(seconds: 1),
    reverseTransitionDuration: const Duration(seconds: 1),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      Offset begin = Offset(isLeft ? -1 : 1, 0.0);
      Offset end = Offset.zero;
      final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeOutExpo));
      final offsetAnimation = animation.drive(tween);

      return SlideTransition(
          position: offsetAnimation,
          child: child,
      );
    },
  ));
}

void routeToPage(BuildContext context, page) {
 Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) => page));
}

AppBar appBar(String title) => AppBar(title: Text(title));

BottomNavigationBar bottomBar(BuildContext context) => BottomNavigationBar(
      onTap: (value) {
        if (Settings.pageIndex == 0) {
          Settings.saveSettings();
        }

        final int oldPageIndex = Settings.pageIndex;
        Settings.pageIndex = value;

        if (oldPageIndex == Settings.pageIndex) return;

        Settings.pushPageIndex(oldPageIndex);

        switch (Settings.pageIndex) {
          case 0: // Settings
            routeToMainPage(context, const SettingsPage(), oldPageIndex > Settings.pageIndex);
          case 1: // Roll page
            routeToMainPage(context, const RollerPage(), oldPageIndex > Settings.pageIndex);
          case 2: // Dice Themes
            routeToMainPage(context, const SetupPage(), oldPageIndex > Settings.pageIndex);
        }

      },
      currentIndex: Settings.pageIndex,
      items: [
        BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            activeIcon: const Icon(Icons.settings_applications),
            label: StringConsts.settings.title),
        BottomNavigationBarItem(
            icon: const Icon(Icons.add_box_outlined),
            activeIcon: const Icon(Icons.add_box),
            label: StringConsts.roller.title),
        BottomNavigationBarItem(
            icon: const Icon(Icons.square_outlined),
            activeIcon: const Icon(Icons.square_rounded),
            label: StringConsts.diceTheme.title)
      ],
    );

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

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

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
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: accentColor.main,
                  selectedItemColor: accentColor.secondary,
                  unselectedItemColor: Colors.white30,
                ),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: accentColor.tertiary,
                    foregroundColor: accentColor.secondary),
                elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => accentColor.main),
                        foregroundColor: MaterialStateColor.resolveWith(
                            (states) => accentColor.secondary)))),
        home: const RollerPage());
  }
}
