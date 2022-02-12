import 'package:flutter/material.dart';

class ShadowText extends StatelessWidget {
  const ShadowText(this.data,
      {Key key,
      this.style,
      this.textAlign = TextAlign.start,
      this.shadowColor = Colors.black,
      this.offsetX = 2.0,
      this.offsetY = 2.0,
      this.blur = 2.0})
      : assert(data != null),
        super(key: key);

  final String data;
  final TextStyle style;
  final Color shadowColor;
  final double offsetX;
  final double offsetY;
  final double blur;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: textAlign,
      style: style.copyWith(
          ),
    );
  }
}