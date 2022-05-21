import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedBackPage extends StatelessWidget {
  const FeedBackPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8, right: 8, left: 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    tooltip: "Back",
                    //Adaptive back button for full native experience.
                    icon: Icon(Icons.adaptive.arrow_back),
                    splashRadius: 24,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    "Send feedback",
                    style: TextStyle(
                      fontSize: 30,
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                ideaMail();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        Icons.lightbulb_outline_rounded,
                        size: 30,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "I have a suggestion",
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                issueMail();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        Icons.sentiment_dissatisfied_outlined,
                        size: 30,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "I dont like something",
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                satisfiedMail();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        Icons.insert_emoticon_outlined,
                        size: 30,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Am satisfied with the app",
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//TODO: Add feedback email.
void ideaMail() async {
  String email = "";
  String subject = "I have an Idea";
  var mailurl = "mailto:$email?subject=${Uri.encodeFull(subject)}";
  if (await canLaunch(mailurl)) {
    await launch(mailurl);
  } else {
    throw "Error occured";
  }
}

void issueMail() async {
  String email = "";
  String subject = "Something is not working properly";
  var mailurl = "mailto:$email?subject=${Uri.encodeFull(subject)}";
  if (await canLaunch(mailurl)) {
    await launch(mailurl);
  } else {
    throw "Error occured";
  }
}

void satisfiedMail() async {
  String email = "";
  String subject = "Am happy with a feature";
  var mailurl = "mailto:$email?subject=${Uri.encodeFull(subject)}";
  if (await canLaunch(mailurl)) {
    await launch(mailurl);
  } else {
    throw "Error occured";
  }
}
