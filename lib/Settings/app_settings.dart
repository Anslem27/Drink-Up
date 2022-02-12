import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({Key key}) : super(key: key);

  @override
  _AppSettingsState createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
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
            ],
          ),
        ),
      ),
    );
  }
}
