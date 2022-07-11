import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

//beautiful snackbar-like toast for error messages
class FancySnackBar extends StatelessWidget {
  final String title, body;
  final Widget widget;
  const FancySnackBar(
      {Key key,
      @required this.body,
      @required this.title,
      @required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(20.0),
          height: 85,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              const SizedBox(width: 48),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                          GoogleFonts.roboto(fontSize: 18, color: Colors.white),
                    ),
                    const Spacer(),
                    Text(
                      body,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: ClipRRect(
            borderRadius:
                const BorderRadius.only(bottomLeft: Radius.circular(20)),
            child: SvgPicture.asset(
              "assets/svg/bubbles.svg",
              height: 48,
              width: 40,
              color: const Color(0xff801336),
            ),
          ),
        ),
        Positioned(
          top: -14,
          left: 0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                "assets/svg/fail.svg",
                height: 35,
              ),
              Positioned(
                top: 8,
                child: widget,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//used when displaying fancy info toasts
class InfoToast extends StatelessWidget {
  final String title, body;
  final Widget widget;

  const InfoToast(
      {Key key,
      @required this.body,
      @required this.title,
      @required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(20.0),
          height: 85,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              const SizedBox(width: 48),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                          GoogleFonts.roboto(fontSize: 18, color: Colors.white),
                    ),
                    const Spacer(),
                    Text(
                      body,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: ClipRRect(
            borderRadius:
                const BorderRadius.only(bottomLeft: Radius.circular(20)),
            child: SvgPicture.asset(
              "assets/svg/bubbles.svg",
              height: 48,
              width: 40,
              color: const Color.fromARGB(255, 45, 16, 187),
            ),
          ),
        ),
        Positioned(
          top: -14,
          left: 0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                "assets/svg/fail.svg",
                height: 35,
                color: const Color.fromARGB(255, 45, 16, 187),
              ),
              Positioned(
                top: 8,
                child: widget,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
