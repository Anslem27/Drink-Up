import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'actions/history_actions.dart';
import 'actions/settings_actions.dart';
import 'middleware/middleware.dart';
import 'model/app_state.dart';
import 'reducers/app_state_reducer.dart';
import 'screens/home/home_page.dart';

class WatermaniacApp extends StatelessWidget {
  final store = Store(appReducer,
      initialState: AppState.defaultState(),
      middleware: createStoreMiddleware());

  WatermaniacApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFF4C9BFB),
        accentColor: const Color(0xFFF66BBE),
        // f5bad3 (pinkish), c7d0df (grayish), fcfbfe (whiteish)
      ),
      home: StoreProvider(
        store: store,
        child: StoreBuilder<AppState>(
          onInit: (store) {
            store.dispatch(LoadDrinkHistoryAction());
            store.dispatch(LoadAppSettingsAction());
          },
          builder: (context, store) {
            return Material(
              type: MaterialType.transparency,
              child: HomePage(),
            );
          },
        ),
      ),
    );
  }
}
