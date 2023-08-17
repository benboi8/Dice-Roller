import 'package:dice_roller/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dice.dart';
import 'dice_style.dart';
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
    return WillPopScope(
      onWillPop: () async {
        Settings.popPageIndex();
        return true;
      },
      child: Scaffold(
        appBar: appBar(StringConsts.roller.title),
        bottomNavigationBar: bottomBar(context),
        body: Column(
            children: [
              const SizedBox(height: 20),
              Slider(
                onChanged: (value) => setState(() {Settings.sides = value.round();}),
                value: Settings.sides.roundToDouble(),
                min: Settings.minSides,
                max: Settings.maxSides,
                divisions: (Settings.maxSides - Settings.minSides).round(),
              ),
              const Spacer(),
              Text(Settings.sides.toString()),
              const Spacer(flex: 2),
              Center(
                child: SizedBox(
                  width: DiceStyler.width,
                  height: DiceStyler.height,
                  child: Center(child: Dice.getFace(Dice.getLatest())),
                ),
              ),
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
                          if (Settings.flipScreen) {
                            if (Settings.down) {
                              SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
                              Settings.down = false;
                            } else {
                              SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown]);
                              Settings.down = true;
                            }
                          }
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
              const SizedBox(height: 20),
            ],
          ),
      ),
    );
  }
}
