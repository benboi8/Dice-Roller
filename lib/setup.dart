import 'package:flutter/material.dart';

import 'page_manager.dart';
import 'settings.dart';
import 'string_consts.dart';

class SetupPage extends StatefulWidget {
  const SetupPage({super.key});

  @override
  State<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  @override
  Widget build(BuildContext context) {
    PageManager.pageIndex = PageManager.setupPage;
    return WillPopScope(
      onWillPop: () async {
        PageManager.popPageIndex();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(StringConsts.setup.title),
          automaticallyImplyLeading: false,
        ),
        // bottomNavigationBar: bottomBar(context),
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
            const SizedBox(height: 20),
            Center(child: Text(Settings.sides.toString(), style: const TextStyle(fontSize: 20))),
            Row(
              children: [
                const Expanded(child: SizedBox()),
                Expanded(flex: 3, child: ElevatedButton(
                  onPressed: () {setState(() {});},
                  child: Text(StringConsts.setup.addDice(Settings.sides)),
                )),
                const Expanded(child: SizedBox()),
                Expanded(flex: 3, child: ElevatedButton(
                  onPressed: () {setState(() {});},
                  child: Text(StringConsts.setup.removeDice),
                )),
                const Expanded(child: SizedBox()),
              ],
            )
          ],
        ),
      ),
    );
  }
}
