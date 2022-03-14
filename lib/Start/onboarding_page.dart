import 'package:introduction_screen/introduction_screen.dart';

import 'package:flutter/material.dart';

class Onbording extends StatelessWidget {
  List<PageViewModel> onboardingpages(context) {
    return [
      PageViewModel(
        image: Image.asset(''),
        title: '',
        body: "",
      ),
      PageViewModel(
        image: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(''),
        ),
        title: '',
        body: '',
      ),
      PageViewModel(
        image: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Image.asset(''),
        ),
        title: '',
        body: '',
      ),
      PageViewModel(
        image: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Image.asset(''),
        ),
        title: '',
        body: '',
        footer: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.flight_takeoff, color: Color(0xFF0096FF)),
          label: const Text("Get Started"),
        ),
      ),
    ];
  }

  const Onbording({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: IntroductionScreen(
          showNextButton: true,
          showSkipButton: false,
          showDoneButton: false,
          globalBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          onDone: () {},
          next: const Text(
            "Next",
            style: TextStyle(color: Color(0xFF0096FF)),
          ),
          pages: onboardingpages(context),
        ),
      ),
    );
  }
}
