import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Addons/waterly_facts.dart';
import '../../Models/app_state.dart';
import '../../Settings/app_settings.dart';
import '../../actions/settings_actions.dart';
import 'Gender.dart';
import 'widgets/age_card.dart';
import 'widgets/daily_goal_card.dart';
import 'widgets/gender_card.dart';

typedef OnSaveCallback = Function({Gender gender, int age, int dailyGoal});

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return SafeArea(
            child: StoreConnector<AppState, OnSaveCallback>(
              converter: (store) {
                return ({gender, age, dailyGoal}) {
                  var settings = store.state.settings
                      .copyWith(gender: gender, age: age, dailyGoal: dailyGoal);
                  store.dispatch(SaveSettingsAction(settings));
                };
              },
              builder: (context, callback) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      userActivity(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          userProfile(),
                          genderAgeView(callback, state)
                        ],
                      ),
                      bottomBody(state, callback, context),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Column bottomBody(
      AppState state, OnSaveCallback callback, BuildContext context) {
    return Column(
      children: [
        //?dailyGoal card method.
        dailyGoalCard(state, callback),
        const SizedBox(height: 10),
        //? Random Water Facts
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 8, right: 8),
              decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 25, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Watery Facts",
                            style: GoogleFonts.raleway(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 3),
                          IconButton(
                            splashRadius: 24,
                            onPressed: () {},
                            icon: const Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        randomFact,
                        maxLines: 5,
                        style: GoogleFonts.raleway(
                          fontSize: 18,
                          //fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  DailyGoalCard dailyGoalCard(AppState state, OnSaveCallback callback) {
    return DailyGoalCard(
      age: state.settings.age,
      gender: state.settings.gender,
      changed: (dG) {
        callback(dailyGoal: dG);
      },
      dailyGoal: state.settings.dailyGoal,
    );
  }

  Column genderAgeView(OnSaveCallback callback, AppState state) {
    return Column(
      children: [
        //?Gender Card
        GenderSelectorCard(
          changed: (g) {
            callback(gender: g);
          },
          value: state.settings.gender,
        ),
        //?Age card
        AgeSelectorCard(
          changed: (a) {
            callback(age: a);
          },
          value: state.settings.age,
        ),
      ],
    );
  }

  userActivity() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 8, right: 8, left: 8),
      child: Row(
        children: [
          Text(
            "My Profile",
            style: GoogleFonts.raleway(fontSize: 28),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const AppSettings(),
                ),
              ),
              tooltip: "Menu",
              icon: const Icon(
                Icons.auto_awesome_mosaic_rounded,
                size: 30,
                semanticLabel: "Menu",
              ),
              splashRadius: 25,
            ),
          ),
        ],
      ),
    );
  }

  userProfile() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Stack(
              children: [
                Container(
                  height: 220,
                  width: MediaQuery.of(context).size.width / 2.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red[100],
                  ),
                  child: Stack(
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 37,
                          backgroundImage: AssetImage(
                            "assets/icons/avatar.png",
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "Hi There...",
                            style: GoogleFonts.raleway(fontSize: 22),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: TextButton.icon(
                            style: TextButton.styleFrom(
                              primary: Colors.black,
                            ),
                            onPressed: () {},
                            icon: const Icon(Icons.edit),
                            label: const Text("Edit Avatar"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
