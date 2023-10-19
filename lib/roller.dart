import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'dice.dart';
import 'history.dart';
import 'page_manager.dart';
import 'settings.dart';
import 'string_consts.dart';

class RollerPage extends StatefulWidget {
  const RollerPage({super.key});

  @override
  State<RollerPage> createState() => _RollerPageState();
}

class _RollerPageState extends State<RollerPage> {
  late Timer timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  void rollDice() async {
    setState(() {
      Dice(Settings.sides);
    });
  }

  @override
  Widget build(BuildContext context) {
    PageManager.pageIndex = PageManager.rollerPage;
    return WillPopScope(
      onWillPop: () async {
        PageManager.popPageIndex();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(StringConsts.roller.title),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  PageManager.routeToPage(context, const HistoryPage());
                },
                icon: const Icon(Icons.history)),
            IconButton(
                onPressed: () {
                  PageManager.routeToPage(context, const SettingsPage());
                },
                icon: const Icon(Icons.settings))
          ],
        ),
        body: Column(
          children: [
            const Spacer(),
            Settings.addSecondButton
                ? Transform.rotate(
                    angle: pi,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Expanded(child: SizedBox()),
                        Expanded(
                          flex: 4,
                          child: ElevatedButton(
                            onPressed: () => rollDice(),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                  StringConsts.roller.rollDice(Settings.sides)),
                            ),
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                      ],
                    ),
                  )
                : Container(),
            Settings.addSecondButton ? const Spacer(flex: 2) : Container(),
            Settings.addSecondButton
                ? Transform.rotate(
                    angle: pi,
                    child: Text(
                        StringConsts.roller.youRolled(Dice.getLatest().number),
                        style: const TextStyle(fontSize: 20)))
                : Container(),
            Settings.addSecondButton ? const Spacer(flex: 2) : Container(),
            Center(child: Dice.getLatest().getFace()),
            const Spacer(flex: 2),
            Text(StringConsts.roller.youRolled(Dice.getLatest().number),
                style: const TextStyle(fontSize: 20)),
            const Spacer(flex: 2),
            Slider(
              value: Settings.sides.toDouble(),
              onChanged: (value) {
                setState(() {
                  Settings.sides = value.round();
                });
              },
              divisions: (Settings.maxSides - Settings.minSides).round(),
              max: Settings.maxSides,
              min: Settings.minSides,
              label: Settings.sides.toString(),
            ),
            const Spacer(flex: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Expanded(child: SizedBox()),
                Expanded(
                  flex: 4,
                  child: ElevatedButton(
                    onPressed: () => rollDice(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(StringConsts.roller.rollDice(Settings.sides)),
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
            Settings.addSecondButton
                ? const Spacer()
                : const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
