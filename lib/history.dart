import 'package:dice_roller/dice.dart';
import 'package:dice_roller/dice_style.dart';
import 'package:flutter/material.dart';

import 'settings.dart';
import 'string_consts.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(StringConsts.history.title)),
      body: ListView.builder(
        itemCount: Dice.length * 2,
        addAutomaticKeepAlives: false,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const SizedBox(height: 10);
          }
          else if (index % 2 == 0) {
            return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(indent: DiceStyler.width / 3, endIndent: DiceStyler.width / 3, color: Settings.accentColor.tertiary),
              const SizedBox(height: 5)
            ],
          );
          } else {
            Dice dice = Dice.getHistory(((index - 1) / 2).round());
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(child: Text("Dice had: ${dice.sides} sides", style: const TextStyle(fontSize: 20),)),
                Center(child: Text("Rolled at: ${dice.time}", style: const TextStyle(fontSize: 20),)),
                Center(child: dice.getFace()),
              ],
            );
          }
        },
      ),
    );
  }
}
