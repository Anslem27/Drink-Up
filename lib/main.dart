import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:drink_up/Addons/Pages/splash_screen.dart';
import 'package:flutter/material.dart';
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
import 'screens/profile/profile_page.dart';
import 'screens/today/today_page.dart';
import 'styles/app_theme.dart';

// APP NAME: Drink Up
void main() {
  AwesomeNotifications().initialize('resource://drawable/ic_launcher', [
    NotificationChannel(
      channelKey: 'basic_channel',
      channelName: 'Basic Notifications',
      // defaultColor: const Color(0xff7fffd4),
      channelDescription: 'Minimal basic notifications for drink up',
      importance: NotificationImportance.High,
      channelShowBadge: true,
    ),
    NotificationChannel(
      channelKey: 'scheduled_channel',
      channelName: 'Scheduled Notifications',
      channelDescription: 'Scheduled Notifications channel',
      locked: true,
      importance: NotificationImportance.High,
    )
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final store = Store(appReducer,
      initialState: AppState.defaultState(),
      middleware: createStoreMiddleware());

  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: GetMaterialApp(
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
        home: const SplashScreen(),
      ),
    );
  }
}

class HomeController extends StatelessWidget {
  const HomeController({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      onInit: (store) {
        store.dispatch(LoadDrinkHistoryAction());
        store.dispatch(LoadAppSettingsAction());
      },
      builder: (context, store) {
        return const HomePage();
      },
    );
  }
}
