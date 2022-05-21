import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Aboutpage extends StatefulWidget {
  const Aboutpage({Key? key}) : super(key: key);

  @override
  State<Aboutpage> createState() => _AboutpageState();
}

class _AboutpageState extends State<Aboutpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                      "About",
                      style: TextStyle(
                        fontSize: 30,
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                  ],
                ),
              ),
              versionStatus(context),
              SizedBox(height: MediaQuery.of(context).size.height / 18),
              Text(
                "Support",
                style: GoogleFonts.nunitoSans(
                  fontSize: 22,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 50),
              aboutBody(),
            ],
          ),
        ),
      ),
    );
  }

  aboutBody() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(color: Theme.of(context).highlightColor),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: const [
                Text(
                  "Provide feedback",
                  style: TextStyle(
                    fontSize: 19,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(Icons.feed_outlined),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: const [
                Text(
                  "Change log",
                  style: TextStyle(
                    fontSize: 19,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(Icons.book_online_outlined),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: const [
                Text(
                  "Rate on playstore",
                  style: TextStyle(
                    fontSize: 19,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(Icons.stars_outlined),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: const [
                Text(
                  "Privacy policy",
                  style: TextStyle(
                    fontSize: 19,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(Icons.shield_outlined),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: const [
                Text(
                  "Replay Intro",
                  style: TextStyle(
                    fontSize: 19,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(Icons.start_rounded),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  versionStatus(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(color: Theme.of(context).highlightColor),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        children: [
          Image.asset(
            "assets/images/drinkup.png",
            height: 160,
            width: 120,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Drink up",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Text(
            "Version: 0.0 beta",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Image.asset("assets/settings/github.png",
                        height: 40, width: 40),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Image.asset("assets/settings/email-us.png",
                        height: 40, width: 40),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
