import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 3),
      //?After  3 seconds,homepage loads.
      () async {
        Get.off(() => const HomeController());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Theme.of(context).hintColor,
          body: SafeArea(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 2),
                const LoadingIcon(),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Center(
            child: Image.asset(
              "assets/images/drinkup.png",
              width: 98,
              height: 150,
            ),
          ),
        )
      ],
    );
  }
}

class LoadingIcon extends StatelessWidget {
  const LoadingIcon({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitRipple(
        color: Colors.white,
        size: 30.0,
      ),
    );
  }
}
