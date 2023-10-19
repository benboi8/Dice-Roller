class StringConsts {
  static RollerStrings roller = RollerStrings();
  static SettingsStrings settings = SettingsStrings();
  static AccentStrings accents = AccentStrings();
  static SetupStrings setup = SetupStrings();
  static HistoryStrings history = HistoryStrings();

  static String getA(int sides) => sides.toString().startsWith("8") ? 'an' : 'a';

  static String getSides(int sides) {
    return "${getA(sides)} $sides sided";
  }
}

class RollerStrings {
  String get title => "Roll a Dice";
  String rollDice(int sides) => "Roll ${StringConsts.getSides(sides)} die";
  String youRolled(int sides) => "You rolled ${StringConsts.getA(sides)} $sides!";
}

class SettingsStrings {
  String get title => "Settings";
  String get darkMode => "Dark Mode";
  String get addSecondButton => "Two player mode";
  String get addSecondButtonDesc => "Adds an inverted Button at the top of the screen for a second player.";
  String get fastAnimations => "Speeds up the animation of the dice.";
}

class AccentStrings {
  String get title => "Accents";
}

class SetupStrings {
  String get title => "Dice Setup";
  String addDice(int sides) => "Add ${StringConsts.getSides(sides)} dice ";
  String get removeDice => "Remove the last dice added";
}

class HistoryStrings {
  String get title => "Dice History";
}
