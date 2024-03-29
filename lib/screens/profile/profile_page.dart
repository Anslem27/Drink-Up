import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import '../../Addons/random_lists.dart';
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
  //image instance
  // File image;
  // Future pickImage() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if (image == null) return;
  //     final permanentImage = await saveImagePermanently(image.path);
  //     //final imageTemporary = File(image.path);
  //     setState(() {
  //       this.image = permanentImage;
  //     });
  //   } on PlatformException catch (e) {
  //     //? Just incase user denies persmission for camera.
  //     // ignore: avoid_print
  //     print("Failed to pick image: $e");
  //   }
  // }

  // Future<File> saveImagePermanently(String imagePath) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final name = basename(imagePath);
  //   final image = File("${directory.path}/$name");
  //   return File(imagePath).copy(image.path);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (_, isScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Text(
                "My Profile",
                style: GoogleFonts.roboto(
                  fontSize: 30,
                  color: Theme.of(context).focusColor,
                ),
              ),
              pinned: true,
              floating: true,
              forceElevated: isScrolled,
              actions: [
                IconButton(
                  onPressed: () => Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (_) => const AppSettings(),
                    ),
                  ),
                  tooltip: "Menu",
                  icon: const Icon(
                    Iconsax.setting,
                    size: 30,
                    semanticLabel: "Menu",
                  ),
                  splashRadius: 25,
                ),
              ],
            )
          ];
        },
        body: profileBodyBlock(),
      ),
    ));
  }

  StoreConnector<AppState, AppState> profileBodyBlock() {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return StoreConnector<AppState, OnSaveCallback>(
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
        );
      },
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
                        Iconsax.book,
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
                    style: GoogleFonts.roboto(
                      fontSize: 19.5,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    factImageDissolver,
                    height: 100,
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
                      const Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 40,
                          backgroundImage: AssetImage(
                            "assets/illustrations/man-1.png",
                          ),
                        ), /* image != null
                            ? ClipOval(
                                child: Image.file(
                                  // image!,
                                  //? null check.
                                  image,
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
                              ), */
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
                      // Align(
                      //   alignment: Alignment.bottomCenter,
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(bottom: 10),
                      //     child: TextButton.icon(
                      //       style: TextButton.styleFrom(
                      //         primary: Theme.of(context).focusColor,
                      //       ),
                      //       onPressed: () {
                      //         //pickImage();
                      //       },
                      //       icon: const Icon(Icons.edit),
                      //       label: const Text("Edit Avatar"),
                      //     ),
                      //   ),
                      // ),
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
