import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrate_me/Settings/reusable_widgets.dart';

// Theme,notifications,share,rate us,about,privacy pollicy,contact us,whats new
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

  settingsBody() {
    return Column(
      children: [
        ReusableSettings(
          image: "assets/settings/theme-icon.png",
          onTap: () {},
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
