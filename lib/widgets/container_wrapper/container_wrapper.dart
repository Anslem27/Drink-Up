import 'package:flutter/material.dart';

class ContainerWrapper extends StatelessWidget {
  final Widget child;
  final double widthScale;

  const ContainerWrapper({Key key, @required this.child, this.widthScale = 0.8})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * widthScale,
      child: Container(
        color: Colors.transparent,
        child: Container(
          decoration: const BoxDecoration(
              color: Color(0xe6ffffff),
              boxShadow: [BoxShadow(color: Color(0x28000000), blurRadius: 5.0)],
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          child: child,
        ),
      ),
    );
  }
}
