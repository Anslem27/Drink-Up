import '../managers/database/drink_history.dart';
import 'settings/AppSettings.dart';
import 'water/Glass.dart';

class AppState {
  final AppSettings settings;
  final Glass glass;
  final List<DrinkHistoryEntry> drinksHistory;

  AppState({this.settings, this.glass, this.drinksHistory});

  factory AppState.defaultState() {
    var settings = AppSettings(dailyGoal: 0);
    var glass = Glass(0, 0);
    return AppState(settings: settings, glass: glass, drinksHistory: []);
  }
}
