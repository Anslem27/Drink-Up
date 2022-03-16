import 'package:drink_up/Settings/Widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import '../Addons/feedback.dart';
import '../styles/theme_controller.dart';
import 'About/about_page.dart';

ThemeMode thememode = ThemeMode.system;

// TODO: Suggest a new feature.
class AppSettings extends StatefulWidget {
  const AppSettings({Key key}) : super(key: key);

  @override
  _AppSettingsState createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  final spaceBtn = const SizedBox(height: 10);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 8, right: 8, left: 8),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      tooltip: "Back",
                      //?remeber adaptive back button for full native experience.
                      icon: Icon(Icons.adaptive.arrow_back),
                      splashRadius: 25,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      "Settings",
                      style: TextStyle(
                        fontSize: 30,
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "General",
                  style: TextStyle(
                    fontSize: 19.5,
                    color: Colors.grey,
                  ),
                ),
              ),
              settingsBody(),
            ],
          ),
        ),
      ),
    );
  }

  final themeController = Get.put(ThemeController());

  //? Change app theme dialog.
  //!FIXME save user theme state.
  Widget themeChanger() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/settings/theme-icon.png",
              height: 50,
              width: 50,
            ),
            Text(
              "Choose theme",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).hoverColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 150,
              child: Row(
                children: <Widget>[
                  Radio(
                    value: ThemeMode.light,
                    groupValue: thememode,
                    onChanged: (val) {
                      thememode = val;
                      setState(() {
                        themeController.changeThemeMode(ThemeMode.light);
                        themeController.saveTheme(true);
                      });
                    },
                  ),
                  const Flexible(
                    child: Text(
                      'Light',
                      style: TextStyle(fontSize: 15),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 150,
              child: Row(
                children: <Widget>[
                  Radio(
                    value: ThemeMode.dark,
                    groupValue: thememode,
                    onChanged: (val) {
                      thememode = val;
                      setState(() {
                        themeController.changeThemeMode(ThemeMode.dark);
                        themeController.saveTheme(false);
                      });
                    },
                  ),
                  const Flexible(
                    child: Text(
                      'Dark',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 150,
              child: Row(
                children: <Widget>[
                  Radio(
                      value: ThemeMode.system,
                      groupValue: thememode,
                      onChanged: (val) {
                        thememode = val;
                        setState(() {
                          themeController.changeThemeMode(ThemeMode.system);
                          themeController.saveTheme(false);
                        });
                      }),
                  const Flexible(
                    child: Text(
                      'System Default',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  settingsBody() {
    return Column(
      children: [
        ReusableSettings(
          image: "assets/settings/theme-icon.png",
          onTap: () => showDialog(
            context: context,
            builder: (_) => themeChanger(),
          ),
          header: "Theme",
          subtitle: "General App theme appearance",
        ),
        spaceBtn,
        ReusableSettings(
          image: "assets/settings/share.png",
          onTap: () {},
          header: "Share",
          subtitle: "Share with a friend",
        ),
        spaceBtn,
        ReusableSettings(
          image: "assets/settings/rate.png",
          onTap: () => showSlidingBottomSheet(
            context,
            builder: (_) => SlidingSheetDialog(
              duration: const Duration(milliseconds: 500),
              cornerRadius: 16,
              snapSpec: const SnapSpec(
                initialSnap: 0.8,
                snappings: [0.8, 0.8],
              ),
              builder: (_, SheetState state) {
                return ratingBottomSheet(context);
              },
            ),
          ),
          header: "Rate Us",
          subtitle: "Rate your experience with the app",
        ),
        spaceBtn,
        ReusableSettings(
          image: "assets/settings/privacy.png",
          onTap: () {},
          header: "Privacy Policy",
          subtitle: "Terms and conditions of use",
        ),
        spaceBtn,
        ReusableSettings(
          image: "assets/settings/new.png",
          onTap: () => showDialog(
            context: context,
            builder: (_) => newDialog(),
          ),
          header: "Whats New",
          subtitle: "Discover New App features",
        ),
        spaceBtn,
        ReusableSettings(
          image: "assets/settings/faq.png",
          onTap: () {},
          header: "Faq's",
          subtitle: "Frequently Asked Questions",
        ),
        spaceBtn,
        ReusableSettings(
          image: "assets/settings/rate.png",
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const FeedBackPage(),
            ),
          ),
          header: "Contact Us",
          subtitle: "Report or Suggest an Issue",
        ),
        spaceBtn,
        ReusableSettings(
          image: "assets/settings/information-button.png",
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const Aboutpage(),
            ),
          ),
          header: "About",
          subtitle: "App build info",
        ),
      ],
    );
  }

//? rating bottomsheet
  ratingBottomSheet(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 8,
              width: MediaQuery.of(context).size.width / 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.blue[300],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.5, top: 15.0),
              child: Image.asset(
                "assets/images/drinkup.png",
                height: 110,
                width: 110,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 50),
            const Padding(
              padding: EdgeInsets.all(3.5),
              child: Text(
                "Thank you for using the Drink up app",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 19),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 50),
            const Padding(
              padding: EdgeInsets.all(3.5),
              child: Text(
                "You can show your love by leaving a great rating, or donating to help improve the app and as well as sharing to all your friends.",
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(3.5),
              child: Text(
                "A five star rating is also a great contribution and keeps us motivated to introduce more new features.\n And dont forget to hydrate",
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 40),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 130,
                      width: MediaQuery.of(context).size.width / 2.2,
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.yellowAccent),
                      ),
                      child: Center(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 10.0, bottom: 8.0),
                            child: Icon(
                              Icons.star_border_outlined,
                              color: Colors.yellowAccent,
                              size: 35,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8.0,
                            ),
                            child: Text(
                              "Rate 5 stars on playstore",
                              style: TextStyle(color: Colors.blue[100]),
                            ),
                          )
                        ],
                      )),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 130,
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      width: MediaQuery.of(context).size.width / 2.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.redAccent)),
                      child: Center(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 10.0, bottom: 8.0),
                            child: Icon(
                              Icons.email_outlined,
                              color: Colors.redAccent,
                              size: 35,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8.0,
                            ),
                            child: Text(
                              "Contact us by email",
                              style: TextStyle(color: Colors.red[200]),
                            ),
                          )
                        ],
                      )),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  //? Whats New Dialog
  Widget newDialog() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "📣 Whats new!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).hoverColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Column(
                children: [
                  Image.asset("assets/settings/marketing.png",
                      height: 80, width: 60),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 5.0,
                      right: 5,
                      bottom: 5,
                      top: 16,
                    ),
                    child: Text(
                      "We're constantly working on new features, check by once in a while",
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Ok"),
            ),
          ],
        ),
      ),
      clipBehavior: Clip.antiAlias,
    );
  }
}
