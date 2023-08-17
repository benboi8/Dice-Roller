import 'package:dice_roller/preference_manager.dart';
import 'package:flutter/material.dart';

import 'accents.dart';
import 'main.dart';
import 'string_consts.dart';

class Settings {
  static bool flipScreen = false;

  static int sides = 6;
  static double minSides = 2;
  static double maxSides = 9;
  static bool down = true;
  static int pageIndex = 1;

  static Brightness brightness = Brightness.dark;
  static List<AccentColor> accents = [
    AccentColor("Red", Colors.red, Colors.black, Colors.red.shade700),
    AccentColor("Pink", Colors.pink, Colors.white, Colors.pink.shade700),
  ];

  static int selectedAccent = 0;
  static AccentColor accentColor = accents[selectedAccent];

  static void setTheme(int index) {
    selectedAccent = index;
    accentColor = accents[selectedAccent];
  }

  static final List<int> _pageHistory = [];

  static void pushPageIndex(int pageIndex) {
    _pageHistory.add(pageIndex);
  }

  static void popPageIndex() {
    if (_pageHistory.isNotEmpty) {
      pageIndex = _pageHistory.removeLast();
    }
  }

  static void getSettings() {
    brightness = PreferenceManager.getBool(PreferenceManager.darkMode) ?? false ? Brightness.dark : Brightness.light;
    selectedAccent = PreferenceManager.getInt(PreferenceManager.selectedAccent) ?? 0;
    flipScreen = PreferenceManager.getBool(PreferenceManager.flipScreen) ?? false;

  }

  static void saveSettings() {
    PreferenceManager.setBool(PreferenceManager.darkMode, brightness == Brightness.dark);
    PreferenceManager.setInt(PreferenceManager.selectedAccent, selectedAccent);
    PreferenceManager.setBool(PreferenceManager.flipScreen, flipScreen);
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Settings.popPageIndex();
        return true;
      },
      child: Scaffold(
        appBar: appBar(StringConsts.settings.title),
        bottomNavigationBar: bottomBar(context),
        body: ListView(
          children: [
            ElevatedButton(
                onPressed: () {
                  routeToPage(context, const AccentsPage());
                },
                child: Text(StringConsts.accents.title)),
            Card(
              child: ListTile(
                title: Text(StringConsts.settings.darkMode),
                trailing: Switch(
                  onChanged: (bool? value) {
                    setState(() {
                      if (value ?? true) {
                        Settings.brightness = Brightness.dark;
                      } else {
                        Settings.brightness = Brightness.light;
                      }

                      Settings.saveSettings();
                    });
                  }, value: Settings.brightness == Brightness.dark,
                ),
              )
            ),
            Card(
                child: ListTile(
              title: Text(StringConsts.settings.flipScreen),
              subtitle: Text(StringConsts.settings.flipScreenDesc),
              trailing: Switch(
                onChanged: (bool? value) {
                  setState(() {
                    if (value ?? true) {
                      Settings.flipScreen = true;
                    } else {
                      Settings.flipScreen = false;
                    }

                    Settings.saveSettings();
                  });
                },
                value: Settings.flipScreen,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
