import 'package:drink_up/Settings/Widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../styles/theme_controller.dart';

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
            /* ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Done"),
            ), */
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
          image: "assets/settings/send-mail.png",
          onTap: () {},
          header: "Notifications",
          subtitle: "Turn on or off notifications",
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
          onTap: () {},
          header: "Rate Us",
          subtitle: "Rate your experience with the app",
        ),
        spaceBtn,
        ReusableSettings(
          image: "assets/settings/rate.png",
          onTap: () {},
          header: "Privacy Policy",
          subtitle: "Terms and conditions of use",
        ),
        spaceBtn,
        ReusableSettings(
          image: "assets/settings/rate.png",
          onTap: () {},
          header: "Whats New",
          subtitle: "Discover New App features",
        ),
        spaceBtn,
        ReusableSettings(
          image: "assets/settings/rate.png",
          onTap: () {},
          header: "Faq's",
          subtitle: "Frequently Asked Questions",
        ),
        spaceBtn,
        ReusableSettings(
          image: "assets/settings/rate.png",
          onTap: () {},
          header: "Contact Us",
          subtitle: "Report or Suggest an Issue",
        ),
        spaceBtn,
        ReusableSettings(
          image: "assets/settings/information-button.png",
          onTap: () {},
          header: "About",
          subtitle: "App build info",
        ),
      ],
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
                  Image.asset("", height: 60, width: 60),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 5.0,
                      right: 5,
                      bottom: 5,
                      top: 14,
                    ),
                    child: Text(
                      "We're constantly working on  new features, check by once in a while",
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

//?Rating Dialog
  Widget ratingDialog() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Rate the app!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).hoverColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 40),
            const Text(
              "Satisfied with the app 😀,then rate us!!",
              style: TextStyle(color: Colors.grey, fontSize: 17),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 40),
            GestureDetector(
              onTap: () {
                /* => StoreRedirect.redirect(
                  androidAppId: "com.diafcon.alpha",
                  iOSAppId: "com.diafcon.flutterapp"), */
              },
              child: Image.asset(
                "",
                height: 40,
                width: 40,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 40),
            const Text(
              "Something's lacking?, email us here",
              style: TextStyle(color: Colors.grey, fontSize: 17),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 40),
            GestureDetector(
              onTap: () {
                //mailUSIssue();
              },
              child: Image.asset(
                "",
                height: 40,
                width: 40,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Dismiss"),
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
      ),
    );
  }
}
