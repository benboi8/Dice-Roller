import 'dart:math';

import 'package:dice_roller/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dice.dart';
import 'dice_style.dart';
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
                    routeToPage(context, const HistoryPage());
                  },
                  icon: const Icon(Icons.history)
              )
            ],
        ),
        bottomNavigationBar: bottomBar(context),
        body: Column(
            children: [
              const Spacer(),
              Settings.addSecondButton ? Transform.rotate(
                angle: pi,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Expanded(child: SizedBox()),
                    Expanded(
                      flex: 4,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            Dice(Settings.sides);
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(StringConsts.roller.rollDice(Settings.sides)),
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                  ],
                ),
              ) : Container(),
              Settings.addSecondButton ? const Spacer(flex: 2) : Container(),
              Center(child: Dice.getLatest().getFace()),
              const Spacer(flex: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Expanded(child: SizedBox()),
                  Expanded(
                    flex: 4,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          Dice(Settings.sides);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(StringConsts.roller.rollDice(Settings.sides)),
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
              Settings.addSecondButton ? const Spacer() : const SizedBox(height: 20),
            ],
          ),
      ),
    );
  }
}
