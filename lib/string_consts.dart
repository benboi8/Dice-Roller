class StringConsts {
  static RollerStrings roller = RollerStrings();
  static SettingsStrings settings = SettingsStrings();
  static AccentStrings accents = AccentStrings();
  static SetupStrings diceTheme = SetupStrings();
}

class RollerStrings {
  String get title => "Roll a Dice";
  String rollDice(int sides) => "Roll ${sides.toString().startsWith("8") ? 'an' : 'a'} $sides sided die";
}

class SettingsStrings {
  String get title => "Settings";
  String get darkMode => "Dark Mode";
  String get flipScreen => "Flip screen after a dice roll";
  String get flipScreenDesc => "Useful for playing with someone else";
}

class AccentStrings {
  String get title => "Accents";
}

class SetupStrings {
  String get title => "Dice Setup";
}
