import 'package:drink_up/screens/settings/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:get/get.dart';
import 'package:redux/redux.dart';
import 'Models/app_state.dart';
import 'Settings/app_settings.dart';
import 'actions/history_actions.dart';
import 'actions/settings_actions.dart';
import 'middleware/middleware.dart';
import 'reducers/app_state_reducer.dart';
import 'navigation.dart';
import 'screens/history/history_page.dart';
import 'screens/today/today_page.dart';
import 'styles/app_theme.dart';

// APP NAME: Drink Up
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final store = Store(appReducer,
      initialState: AppState.defaultState(),
      middleware: createStoreMiddleware());

  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return GetMaterialApp(
      //named routes.
      routes: <String, WidgetBuilder>{
        "/homepage": (_) => const TodayPage(),
        "/profilepage": (_) => const ProfilePage(),
        "/historypage": (_) => const HistoryPage(),
        "/settingspage": (_) => const AppSettings(),
      },
      debugShowCheckedModeBanner: false,
      //!Theme Changing variable.
      themeMode: thememode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: StoreProvider(
        store: store,
        child: StoreBuilder<AppState>(
          onInit: (store) {
            store.dispatch(LoadDrinkHistoryAction());
            store.dispatch(LoadAppSettingsAction());
          },
          builder: (context, store) {
            return const HomePage();
          },
        ),
      ),
    );
  }
}
