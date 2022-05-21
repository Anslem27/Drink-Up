import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:vector_math/vector_math.dart' as vector;
import '../../../Models/app_state.dart';

class WaterProgress extends StatefulWidget {
  const WaterProgress({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WaterProgressState();
  }
}

class _WaterProgressState extends State<WaterProgress>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        var current = state.glass!.currentWaterAmount;
        var target = state.glass!.waterAmountTarget!;
        var percentage = target > 0 ? current / target * 100 : 100.0;
        var progress = (percentage > 100.0 ? 100.0 : percentage) / 100.0;
        progress = 1.0 - progress;

        //? Current water intake double.
        var currentIntakePercentage =
            (target > 0 ? current / target * 100 : 100).toStringAsFixed(0);
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Center(
                      child: Image.asset(
                        'assets/bottle/plastic-bottle.png',
                        fit: BoxFit.scaleDown,
                        height: MediaQuery.of(context).size.height / 2,
                      ),
                    ),
                    Center(
                      child: AnimatedBuilder(
                        animation: CurvedAnimation(
                          parent: animationController,
                          curve: Curves.easeInBack,
                        ),
                        builder: (context, child) => ClipPath(
                          child: Image.asset(
                            'assets/bottle/plastic-bottle-blue.png',
                            height: MediaQuery.of(context).size.height / 2,
                            fit: BoxFit.scaleDown,
                          ),
                          clipper: WaveClipper(
                            progress,
                            (progress > 0.0 && progress < 1.0)
                                ? animationController.value
                                : 0.0,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        children: <Widget>[
                          //TODO handle landscape view fully
                          LayoutBuilder(
                            builder: (context, constraints) {
                              if (constraints.maxWidth < 600) {
                                return Text(
                                  target < current
                                      ? 'Your $currentIntakePercentage%\nof your daily\ngoal.'
                                      : "$currentIntakePercentage%",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: target < current
                                        ? Theme.of(context).focusColor
                                        : Colors.blue[800],
                                    fontSize: target < current ? 17.0 : 40.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              } else {
                                //? Rather useless as appstate doesnt change rather remains constant
                                return Text(
                                  target < current
                                      ? 'Your $currentIntakePercentage%\nof your daily\ngoal.'
                                      : "$currentIntakePercentage%",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: target < current
                                        ? Theme.of(context).focusColor
                                        : Colors.blue[800],
                                    fontSize: target < current ? 15.0 : 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }
                            },
                          ),
                          Text(
                            target < current ? "" : "$current ml",
                            style: TextStyle(
                              color: Colors.blue[800],
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          target < current
                              ? "You have\nreached your\ndaily goal."
                              : "Remaining",
                          style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w500,
                            fontSize: target < current ? 20 : 17.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          target < current
                              ? ""
                              : '${(target - current < 0 ? 0 : target - current)} ml',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: target < current
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 18.0),
                            child: Image.asset(
                              "assets/illustrations/cyborg-prize-cup.png",
                              height: 85,
                              width: 90,
                            ),
                          )
                        : Column(
                            children: <Widget>[
                              Text(
                                'My Target',
                                style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17.5,
                                ),
                              ),
                              Text(
                                '$target ml',
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

//? Custom Wave Clipper.

class WaveClipper extends CustomClipper<Path> {
  final double progress;
  final double animation;

  WaveClipper(this.progress, this.animation);

  @override
  Path getClip(Size size) {
    final double wavesHeight = size.height * 0.1;

    var path = Path();

    if (progress == 1.0) {
      return path;
    } else if (progress == 0.0) {
      path.lineTo(0.0, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0.0);
      path.lineTo(0.0, 0.0);
      return path;
    }

    List<Offset> wavePoints = [];
    for (int i = -2; i <= size.width.toInt() + 2; i++) {
      var extraHeight = wavesHeight * 0.5;
      extraHeight *= i / (size.width / 2 - size.width);
      var dx = i.toDouble();
      var dy = sin((animation * 360 - i) % 360 * vector.degrees2Radians) * 5 +
          progress * size.height -
          extraHeight;
      if (!dx.isNaN && !dy.isNaN) {
        wavePoints.add(Offset(dx, dy));
      }
    }

    path.addPolygon(wavePoints, false);

    // finish the line
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);

    return path;
  }

  @override
  // ignore: avoid_renaming_method_parameters
  bool shouldReclip(WaveClipper old) =>
      progress != old.progress || animation != old.animation;
}
