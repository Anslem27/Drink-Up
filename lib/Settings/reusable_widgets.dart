//...............//?Used with settings rows................................//
import 'package:flutter/material.dart';

class ReusableSettings extends StatelessWidget {
  final String image, header, subtitle;
  final void Function() onTap;
  const ReusableSettings(
      {Key key,
      @required this.image,
      @required this.onTap,
      @required this.header,
      this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 8.0,
            top: 8,
            bottom: 8,
          ),
          child: Image.asset(
            image,
            width: 28,
            height: 28,
          ),
        ),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                header,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              //const Spacer(),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
