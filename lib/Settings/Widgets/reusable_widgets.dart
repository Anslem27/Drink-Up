import 'package:flutter/material.dart';

//...............//?Used with settings rows................................//

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

//...............//?Used with drink dialogs................................//

class QuirkyDialog extends StatelessWidget {
  const QuirkyDialog({
    Key key,
    @required this.title,
    @required this.assetImage,
    @required this.child,
  }) : super(key: key);
  final String title, assetImage;
  final Widget child;
  //primary and secondary color gradients for each

  final primaryColor = const Color(0xff4338CA);
  final secondaryColor = const Color(0xff6D28D9);
  final accentColor = const Color(0xffffffff);
  final backgroundColor = const Color(0xffffffff);
  final errorColor = const Color(0xffEF4444);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            //TODO: Add  better gradients or completely remove them
            colors: [Theme.of(context).highlightColor, const Color(0xff448ee4)],
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage(assetImage),
                radius: 25,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              title,
              style: TextStyle(
                color: accentColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 3.5,
            ),
            //? Any widget
            SizedBox(child: child),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}