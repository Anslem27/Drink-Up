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

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
        Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30, right: 30),
            decoration: BoxDecoration(
              color: Colors.blue[200],
              gradient: const LinearGradient(
                colors: [
                  Color(0xff4338CA),
                  Color(0xff6D28D9),
                ],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Watery Facts",
                        style: GoogleFonts.nunitoSans(
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
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
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    randomFact,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.raleway(
                      fontSize: 19.5,
                    ),
                  ),
                ),
              ],
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
            style: GoogleFonts.nunitoSans(fontSize: 28),
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
                  height: 250,
                  width: MediaQuery.of(context).size.width / 2.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    //color: Colors.red[100],
                    gradient: const LinearGradient(
                      colors: [
                        //TODO: Add different better gradients
                        Color(0xff4338CA),
                        Color(0xff6D28D9),
                      ],
                    ),
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
                              primary: Theme.of(context).focusColor,
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
