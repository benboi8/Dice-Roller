import 'package:dice_roller/page_manager.dart';
import 'package:dice_roller/settings.dart';
import 'package:flutter/material.dart';

import 'main.dart';
import 'string_consts.dart';

class AccentColor {
  String name;
  Color main;
  Color secondary;
  Color tertiary;

  AccentColor(this.name, this.main, this.secondary, this.tertiary);
}

class AccentsPage extends StatefulWidget {
  const AccentsPage({super.key});

  @override
  State<AccentsPage> createState() => _AccentsPageState();
}

class _AccentsPageState extends State<AccentsPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        PageManager.popPageIndex();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: Text(StringConsts.accents.title)),
        body: ListView.builder(
              itemCount: Settings.accents.length * 2,
              itemBuilder: (context, index) {
                if (index % 2 == 1) {
                  AccentColor theme = Settings.accents[((index - 1) / 2).round()];
                  return Card(
                    // color: invertColor(color: theme.main),
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: ListTile(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        title: Text(theme.name, style: TextStyle(color: invertColor(color: theme.main))),
                        tileColor: theme.main,
                        onTap: () {
                          setState(() {
                            Settings.setTheme(((index - 1) / 2).round());
                          });
                        },
                      ),
                    ),
                  );
                } else {
                  return const SizedBox(height: 15);
                }
              },
            ),
      ),
    );
  }
}
