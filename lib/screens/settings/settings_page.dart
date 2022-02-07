import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../actions/settings_actions.dart';
import '../../model/app_state.dart';
import '../../widgets/Reusable Widgets/shadow_text.dart';
import '../../widgets/container_wrapper/container_wrapper.dart';
import 'Gender.dart';
import 'widgets/age_selector_view.dart';
import 'widgets/daily_goal_view.dart';
import 'widgets/gender_selector_view.dart';

typedef OnSaveCallback = Function({Gender gender, int age, int dailyGoal});

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SettingsPageState();
  }
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        Positioned(
          bottom: 0.0,
          height: 160.0,
          child: SizedBox(
            width: size.width,
            height: 160.0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.3, 0.7],
                  colors: [Colors.white.withOpacity(0.0), Colors.white],
                ),
              ),
            ),
          ),
        ),
        StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, state) {
            return SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: ShadowText(
                      'SETTINGS',
                      shadowColor: Colors.black.withOpacity(0.15),
                      offsetX: 3.0,
                      offsetY: 3.0,
                      blur: 3.0,
                      style: const TextStyle(
                          color: Color(0xBEffffff),
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: StoreConnector<AppState, OnSaveCallback>(
                      converter: (store) {
                        return ({gender, age, dailyGoal}) {
                          var settings = store.state.settings.copyWith(
                              gender: gender, age: age, dailyGoal: dailyGoal);
                          store.dispatch(SaveSettingsAction(settings));
                        };
                      },
                      builder: (context, callback) {
                        return ListView(
                          shrinkWrap: false,
                          padding: const EdgeInsets.all(16.0),
                          children: <Widget>[
                            ContainerWrapper(
                              child: GenderSelectorView(
                                changed: (g) {
                                  callback(gender: g);
                                },
                                value: state.settings.gender,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: ContainerWrapper(
                                  child: AgeSelectorView(
                                changed: (a) {
                                  callback(age: a);
                                },
                                value: state.settings.age,
                              )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: ContainerWrapper(
                                  child: DailyGoalView(
                                age: state.settings.age,
                                gender: state.settings.gender,
                                changed: (dG) {
                                  callback(dailyGoal: dG);
                                },
                                dailyGoal: state.settings.dailyGoal,
                              )),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
