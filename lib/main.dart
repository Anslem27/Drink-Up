import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:get/get.dart';
import 'package:redux/redux.dart';
import 'Models/app_state.dart';
import 'actions/history_actions.dart';
import 'actions/settings_actions.dart';
import 'middleware/middleware.dart';
import 'reducers/app_state_reducer.dart';
import 'navigation.dart';
import 'styles/app_theme.dart';

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
      debugShowCheckedModeBanner: false,
      theme: HydratorAppTheme.lightTheme,
      home: StoreProvider(
        store: store,
        child: StoreBuilder<AppState>(
          onInit: (store) {
            store.dispatch(LoadDrinkHistoryAction());
            store.dispatch(LoadAppSettingsAction());
          },
          builder: (context, store) {
            return const Material(
              type: MaterialType.transparency,
              child: HomePage(),
            );
          },
        ),
      ),
    );
  }
}
