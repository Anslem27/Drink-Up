import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:vector_math/vector_math.dart' as Vector;
import '../../../Models/app_state.dart';

class WaterProgress extends StatefulWidget {
  const WaterProgress({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WaterProgressState();
  }
}

class _WaterProgressState extends State<WaterProgress>
    with TickerProviderStateMixin {
  AnimationController animationController;

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
        var current = state.glass.currentWaterAmount;
        //TODO Create bool to display done text when user has finished there target goal.
        //TODO: Make home more dynamic
        var target = state.glass.waterAmountTarget;
        var percentage = target > 0 ? current / target * 100 : 100.0;
        var progress = (percentage > 100.0 ? 100.0 : percentage) / 100.0;
        progress = 1.0 - progress;
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
                      ),
                    ),
                    Center(
                      child: AnimatedBuilder(
                        animation: CurvedAnimation(
                          parent: animationController,
                          curve: Curves.easeInOut,
                        ),
                        builder: (context, child) => ClipPath(
                          child: Image.asset(
                            'assets/bottle/plastic-bottle-blue.png',
                            fit: BoxFit.scaleDown,
                          ),
                          clipper: WaveClipper(
                              progress,
                              (progress > 0.0 && progress < 1.0)
                                  ? animationController.value
                                  : 0.0),
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        children: <Widget>[
                          Text(
                            '${(target > 0 ? current / target * 100 : 100).toStringAsFixed(0)}%',
                            style: TextStyle(
                              color: Colors.blue[800],
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '$current ml',
                            style: TextStyle(
                                color: Colors.blue[800],
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
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
                          //TODO: if(target < current){"Remaining"else{"You have reached your goal"}} ml'}
                          target < current
                              ? "You have reached your daily goal"
                              : "Remaining",
                          style: GoogleFonts.raleway(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          //TODO: if(target < current){'${(target - current)else{"You have reached your goal"}} ml'}
                          '${(target - current < 0 ? 0 : target - current)} ml',
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
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Target',
                          style: GoogleFonts.raleway(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
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
      var dy = sin((animation * 360 - i) % 360 * Vector.degrees2Radians) * 5 +
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
