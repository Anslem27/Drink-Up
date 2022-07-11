import 'package:flutter/material.dart';
// import '../../../util/globals.dart' as globals;

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
              child: Image.asset(assetImage),
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
            const SizedBox(height: 3.5),
            //? Any widget
            SizedBox(child: child),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}

//?..............................................Used with the settings cards..................................//
class SettingsCard extends StatelessWidget {
  const SettingsCard(
      {Key key,
      this.ontap,
      this.leading,
      @required this.subtitle,
      @required this.title,
      this.widget})
      : super(key: key);
  final String title, subtitle;
  final void Function() ontap;
  final Widget widget;
  final Icon leading;

  @override
  Widget build(BuildContext context) {
    // var brightness = MediaQuery.of(context).platformBrightness;
    // bool darkModeOn = (globals.themeMode == ThemeMode.dark ||
    //     (brightness == Brightness.dark &&
    //         globals.themeMode == ThemeMode.system));
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: const EdgeInsets.only(left: 1, right: 1),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            //color: darkModeOn ? const Color(0xff7fffd4) : Colors.grey.shade900,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      //leading icon
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: leading,
                      ),
                      const SizedBox(width: 4),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              subtitle,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      //trainling widget
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: widget,
                      ),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
