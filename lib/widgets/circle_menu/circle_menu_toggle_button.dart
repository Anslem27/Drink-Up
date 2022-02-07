import 'package:flutter/material.dart';

class CircleMenuToggleButton extends StatefulWidget {
  final bool expanded;
  const CircleMenuToggleButton({Key key, this.expanded = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CircleMenuToggleButtonState();
  }
}

class _CircleMenuToggleButtonState extends State<CircleMenuToggleButton>
    with TickerProviderStateMixin {
  AnimationController animationController;
  // final bubbles = <Bubble>[];

  @override
  void initState() {
    super.initState();
  }

  /* @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  } */

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: <Widget>[
          Image.asset(
            widget.expanded
                ? 'assets/buttons/close_menu.png'
                : 'assets/buttons/add_drink.png',
            width: 64.0,
            height: 64.0,
          ),
        ],
      ),
    );
  }
}
