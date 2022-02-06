import 'dart:math';

import 'package:flutter/material.dart';
import 'circle_menu_toggle_button.dart';
import 'layout_overlays.dart';
import 'radial_controller.dart';

class AnchoredRadialMenu extends StatefulWidget {
  final Menu menu;
  final Widget child;

  const AnchoredRadialMenu({
    Key key,
    this.menu,
    this.child,
  }) : super(key: key);

  @override
  _AnchoredRadialMenuState createState() => _AnchoredRadialMenuState();
}

class _AnchoredRadialMenuState extends State<AnchoredRadialMenu> {
  @override
  Widget build(BuildContext context) {
    return AnchoredOverlay(
      showOverlay: true,
      overlayBuilder: (context, rect, anchor) {
        return RadialMenu(anchor: anchor, menu: widget.menu);
      },
      child: widget.child,
    );
  }
}

class RadialMenu extends StatefulWidget {
  final Menu menu;
  final Offset anchor;
  final double radius;

  const RadialMenu({Key key, this.anchor, this.menu, this.radius = 64.0})
      : super(key: key);

  @override
  _RadialMenuState createState() => _RadialMenuState();
}

class _RadialMenuState extends State<RadialMenu>
    with SingleTickerProviderStateMixin {
  RadialMenuController _menuController;

  @override
  void initState() {
    super.initState();

    _menuController = RadialMenuController(
      vsync: this,
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _menuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: buildIcons()..addAll([buildCenter()]),
    );
  }

  Widget buildCenter() {
    final bool expanded = _menuController.state == RadialMenuState.expanded;
    VoidCallback onPressed;
    double scale = 1.0;

    switch (_menuController.state) {
      case RadialMenuState.open:
        scale = 1.0;
        onPressed = () {
          _menuController.expand();
        };
        break;
      case RadialMenuState.expanded:
        scale = 1.0;
        onPressed = () {
          _menuController.collapse();
        };
        break;
      default:
        scale = 1.0;
        break;
    }

    return CenterAbout(
      position: widget.anchor,
      child: Transform(
          transform: Matrix4.identity()..scale(scale, scale),
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: onPressed,
            child: CircleMenuToggleButton(
              expanded: expanded,
            ),
          )),
    );
  }

  List<Widget> buildIcons() {
    const double startAngle = -pi / 2;
    int index = 0;
    int itemsCount = widget.menu.items.length;

    return widget.menu.items.map((RadialMenuItem item) {
      final myAngle = startAngle + (2 * pi * (index / itemsCount));
      ++index;

      return buildIcon(
          text: item.text,
          angle: myAngle,
          bubbleColor: Colors.white,
          textColor: Colors.black,
          onPressed: item.onPressed);
    }).toList(growable: true);
  }

  Widget buildIcon(
      {String text,
      Color bubbleColor,
      Color textColor,
      double angle,
      VoidCallback onPressed}) {
    if (_menuController.state == RadialMenuState.open) {
      return Container();
    }

    double radius = widget.radius;
    double scale = 1.0;

    if (_menuController.state == RadialMenuState.expanding) {
      radius = widget.radius * _menuController.progress;
      scale = _menuController.progress;
    } else if (_menuController.state == RadialMenuState.collapsing) {
      radius = widget.radius * (1.0 - _menuController.progress);
      scale = 1.0 - _menuController.progress;
    }

    return PolarPosition(
      origin: widget.anchor,
      coord: Coord(angle, radius),
      child: Transform(
        transform: Matrix4.identity()..scale(scale, scale),
        alignment: Alignment.center,
        child: IconBubble(
          text: text,
          diameter: 50.0,
          bubbleColor: bubbleColor,
          textColor: textColor,
          onPressed: () {
            _menuController.collapse();
            onPressed();
          },
        ),
      ),
    );
  }
}

class IconBubble extends StatelessWidget {
  final String text;
  final double diameter;
  final Color bubbleColor;
  final Color textColor;
  final VoidCallback onPressed;

  const IconBubble(
      {Key key,
      this.text,
      this.diameter,
      this.bubbleColor,
      this.textColor,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: bubbleColor,
            boxShadow: [
              BoxShadow(color: Colors.black.withAlpha(75), blurRadius: 8.0)
            ]),
        child: Center(
            child: Text(
          text,
          style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
        )),
      ),
    );
  }
}

class PolarPosition extends StatelessWidget {
  final Offset origin;
  final Widget child;
  final Coord coord;

  const PolarPosition(
      {Key key, this.origin = const Offset(0.0, 0.0), this.child, this.coord})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final radialPosition = Offset(origin.dx + (cos(coord.angle) * coord.radius),
        origin.dy + (sin(coord.angle) * coord.radius));

    return CenterAbout(position: radialPosition, child: child);
  }
}

class Menu {
  final List<RadialMenuItem> items;

  Menu({this.items});
}

class RadialMenuItem {
  final String text;
  final onPressed;

  RadialMenuItem({this.text, this.onPressed});
}
