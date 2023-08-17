class StringConsts {
  static RollerStrings roller = RollerStrings();
  static SettingsStrings settings = SettingsStrings();
  static AccentStrings accents = AccentStrings();
  static SetupStrings setup = SetupStrings();
  static HistoryStrings history = HistoryStrings();
}

class RollerStrings {
  String get title => "Roll a Dice";
  String rollDice(int sides) => "Roll ${sides.toString().startsWith("8") ? 'an' : 'a'} $sides sided die";
}

class SettingsStrings {
  String get title => "Settings";
  String get darkMode => "Dark Mode";
  String get addSecondButton => "Adds a second roll button.";
  String get addSecondButtonDesc => "Adds an inverted Button at the top of the screen for a second player.";
}

class AccentStrings {
  String get title => "Accents";
}

class SetupStrings {
  String get title => "Dice Setup";
}

class HistoryStrings {
  String get title => "Dice History";
}
