import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrate_me/Settings/reusable_widgets.dart';

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
                      style: GoogleFonts.raleway(
                          fontSize: 30, color: Theme.of(context).focusColor),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "General",
                  style: GoogleFonts.raleway(
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
                      'System\nDefault',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Done"),
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
}
