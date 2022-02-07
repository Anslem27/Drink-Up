import 'package:redux/redux.dart';

import '../Models/app_state.dart';
import '../actions/history_actions.dart';
import '../actions/settings_actions.dart';
import '../managers/database/database_manager.dart';
import '../managers/database/drink_history.dart';
import '../managers/notifications/notifications_manager.dart';
import '../managers/settings/app_settings_manager.dart';

List<Middleware<AppState>> createStoreMiddleware() {
  final saveSettings = _createSaveSettings();
  final loadSettings = _createLoadSettings();
  final loadDrinksHistory = _createLoadDrinksHistory();
  final addDrinkToHistory = _createAddDrinkToHistory();
  final removeDrinkFromHistory = _createRemoveDrinkFromHistory();
  final saveNotificationSettings = _createSaveNotificationSettings();

  return [
    TypedMiddleware<AppState, LoadDrinkHistoryAction>(loadDrinksHistory),
    TypedMiddleware<AppState, LoadAppSettingsAction>(loadSettings),
    TypedMiddleware<AppState, SaveSettingsAction>(saveSettings),
    TypedMiddleware<AppState, SaveNotificationSettingsAction>(
        saveNotificationSettings),
    TypedMiddleware<AppState, AddDrinkToHistoryAction>(addDrinkToHistory),
    TypedMiddleware<AppState, RemoveDrinkFromHistoryAction>(
        removeDrinkFromHistory),
  ];
}

Middleware<AppState> _createSaveSettings() {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    AppSettingsManager.saveSettings(store.state.settings.gender,
        store.state.settings.age, store.state.settings.dailyGoal);
  };
}

Middleware<AppState> _createSaveNotificationSettings() {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    if (store.state.settings.notificationsEnabled) {
      NotificationsManager.manager.scheduleNotifications(
          store.state.settings.notificationsFromTime,
          store.state.settings.notificationsToTime,
          store.state.settings.notificationsInterval);
    } else {
      NotificationsManager.manager.cancelAll();
    }

    AppSettingsManager.saveNotificationSettings(
        store.state.settings.notificationsEnabled,
        store.state.settings.notificationsFromTime,
        store.state.settings.notificationsToTime,
        store.state.settings.notificationsInterval);
  };
}

Middleware<AppState> _createLoadSettings() {
  return (Store<AppState> store, action, NextDispatcher next) {
    AppSettingsManager.getSettings().then(
      (settings) {
        store.dispatch(
          AppSettingsLoadedAction(settings),
        );
      },
    );

    next(action);
  };
}

Middleware<AppState> _createLoadDrinksHistory() {
  return (Store<AppState> store, action, NextDispatcher next) {
    DatabaseManager.defaultManager
        .fetchAllEntriesOf(DrinkHistoryEntry)
        .then((maps) {
      List<DrinkHistoryEntry> entries = [];
      var table = DrinkHistoryTable();
      // ignore: avoid_function_literals_in_foreach_calls
      maps.forEach((map) {
        DrinkHistoryEntry entry = table.entryFromMap(map);
        entries.add(entry);
      });
      store.dispatch(DrinkHistoryLoadedAction(entries));
    });

    next(action);
  };
}

Middleware<AppState> _createAddDrinkToHistory() {
  return (Store<AppState> store, action, NextDispatcher next) {
    DatabaseManager.defaultManager.insert([action.entry]);

    next(action);
  };
}

Middleware<AppState> _createRemoveDrinkFromHistory() {
  return (Store<AppState> store, action, NextDispatcher next) {
    DatabaseManager.defaultManager.remove([action.entry]);

    next(action);
  };
}
