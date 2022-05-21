import 'dart:io';

import 'package:drink_up/styles/Animations/custom_page_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../Addons/random_lists.dart';
import '../../Models/app_state.dart';
import '../../Settings/app_settings.dart';
import '../../actions/settings_actions.dart';
import 'Gender.dart';
import 'widgets/age_card.dart';
import 'widgets/daily_goal_card.dart';
import 'widgets/gender_card.dart';
import 'package:path/path.dart';

typedef OnSaveCallback = Function({Gender? gender, int? age, int? dailyGoal});

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //image instance
  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final permanentImage = await saveImagePermanently(image.path);
      //final imageTemporary = File(image.path);
      setState(() {
        this.image = permanentImage;
      });
    } on PlatformException catch (e) {
      //? Just incase user denies persmission for camera.
      // ignore: avoid_print
      print("Failed to pick image: $e");
    }
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File("${directory.path}/$name");
    return File(imagePath).copy(image.path);
  }

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
                  var settings = store.state.settings!
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
                      userActivity(context),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          userProfile(context),
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

  bottomBody(AppState state, OnSaveCallback callback, BuildContext context) {
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
            margin: const EdgeInsets.only(left: 15, right: 15),
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text(
                          "Watery Facts",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(width: 3),
                      Icon(
                        Icons.fact_check_outlined,
                        color: Colors.blueAccent,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    randomFact,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunitoSans(
                      fontSize: 19.5,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    factImageDissolver,
                    height: 120,
                    width: 120,
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
      age: state.settings!.age,
      gender: state.settings!.gender,
      changed: (dG) {
        callback(dailyGoal: dG);
      },
      dailyGoal: state.settings!.dailyGoal,
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
          value: state.settings!.gender,
        ),
        //?Age card
        AgeSelectorCard(
          changed: (a) {
            callback(age: a);
          },
          value: state.settings!.age,
        ),
      ],
    );
  }

//TODO: Move to gender card locati0on and incoperate it.
  userActivity(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 8, right: 8, left: 8),
      child: Row(
        children: [
          const Text(
            "My Profile",
            style: TextStyle(fontSize: 30),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () => Navigator.of(context).push(
                CustomPageRoute(
                  destination: const AppSettings(),
                ),
              ),
              tooltip: "Menu",
              icon: const Icon(
                Icons.settings,
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

  /*  //image instance
  File image;
  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporary = File(image.path);
    this.image = imageTemporary;
  } */

  userProfile(context) {
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
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        //TODO: Add different better gradients
                        Theme.of(context).highlightColor,
                        const Color(0xff448ee4)
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child: image != null
                              ? ClipOval(
                                  child: Image.file(
                                    // image!,
                                    //? null check.
                                    image!,
                                    width: 85, height: 85,
                                  ),
                                )
                              //TODO: Create a bool image with an option of a different constant avatar for females and males
                              : const CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 40,
                                  backgroundImage: AssetImage(
                                    "assets/illustrations/man-1.png",
                                  ),
                                )),
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
                            onPressed: () {
                              pickImage();
                            },
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
