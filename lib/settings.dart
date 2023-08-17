import 'package:dice_roller/page_manager.dart';
import 'package:dice_roller/preference_manager.dart';
import 'package:flutter/material.dart';

import 'accents.dart';
import 'main.dart';
import 'string_consts.dart';

class Settings {
  static bool addSecondButton = false;

  static int sides = 6;
  static double minSides = 2;
  static double maxSides = 9;

  static Brightness brightness = Brightness.dark;
  static List<AccentColor> accents = [
    AccentColor("Red", Colors.red, Colors.black, const Color.fromARGB(255, 244, 209, 52)),
    AccentColor("Pink", const Color.fromARGB(225, 221, 149, 153), Colors.white, const Color.fromARGB(255, 221, 200, 151)),
    AccentColor("Blue", Colors.blue, Colors.white, const Color.fromARGB(255, 74, 32, 243)),
  ];

  static int selectedAccent = 0;
  static AccentColor accentColor = accents[selectedAccent];

  static void setTheme(int index) {
    selectedAccent = index;
    accentColor = accents[selectedAccent];
  }

  static void getSettings() {
    brightness = PreferenceManager.getBool(PreferenceManager.darkMode) ?? true ? Brightness.dark : Brightness.light;
    setTheme(PreferenceManager.getInt(PreferenceManager.selectedAccent) ?? 0);
    addSecondButton = PreferenceManager.getBool(PreferenceManager.addSecondButton) ?? false;

  }

  static void saveSettings() {
    PreferenceManager.setBool(PreferenceManager.darkMode, brightness == Brightness.dark);
    PreferenceManager.setInt(PreferenceManager.selectedAccent, selectedAccent);
    PreferenceManager.setBool(PreferenceManager.addSecondButton, addSecondButton);
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
    PageManager.pageIndex = PageManager.settingsPage;
    return WillPopScope(
      onWillPop: () async {
        PageManager.popPageIndex();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
            title: Text(StringConsts.settings.title),
            automaticallyImplyLeading: false
        ),
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
              title: Text(StringConsts.settings.addSecondButton),
              subtitle: Text(StringConsts.settings.addSecondButtonDesc),
              trailing: Switch(
                onChanged: (bool? value) {
                  setState(() {
                    if (value ?? true) {
                      Settings.addSecondButton = true;
                    } else {
                      Settings.addSecondButton = false;
                    }

                    Settings.saveSettings();
                  });
                },
                value: Settings.addSecondButton,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
