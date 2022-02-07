import 'package:redux/redux.dart';

import '../Models/settings/AppSettings.dart';
import '../actions/settings_actions.dart';

final settingsReducers = combineReducers<AppSettings>([
  TypedReducer<AppSettings, AppSettingsLoadedAction>(_setLoadedSettings),
  TypedReducer<AppSettings, SaveSettingsAction>(_setSettings),
  TypedReducer<AppSettings, SaveNotificationSettingsAction>(
      _setNotificationSettings),
]);

AppSettings _setLoadedSettings(
    AppSettings settings, AppSettingsLoadedAction action) {
  return action.settings;
}

AppSettings _setSettings(AppSettings settings, SaveSettingsAction action) {
  return action.settings;
}

AppSettings _setNotificationSettings(
    AppSettings settings, SaveNotificationSettingsAction action) {
  return action.settings;
}
