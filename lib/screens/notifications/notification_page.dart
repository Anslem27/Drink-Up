import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:drink_up/screens/notifications/notification_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'notifications_logic.dart';

class NotificationsSettingsPage extends StatefulWidget {
  const NotificationsSettingsPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NotificationsSettingsPageState();
  }
}

class _NotificationsSettingsPageState extends State<NotificationsSettingsPage> {
  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (isAllowed == false) {
        //TODO: Rework alert widget
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Allow Notifications"),
            content: const Text("Drink up requires notification access"),
            actions: [
              TextButton(
                onPressed: () => AwesomeNotifications()
                    .requestPermissionToSendNotifications()
                    .then(
                      (value) => Navigator.pop(context),
                    ),
                child: const Text("Allow Notifications"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Deny Access"),
              ),
            ],
          ),
        );
      }
    });

    AwesomeNotifications().actionStream.listen((event) {
      //decrement IOS notification count
      if (event.channelKey == "basic_channel" && Platform.isIOS) {
        AwesomeNotifications().getGlobalBadgeCounter().then(
            (value) => AwesomeNotifications().setGlobalBadgeCounter(value - 1));
      }

      //!push user notifications to today Page
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     CupertinoPageRoute(
      //       builder: (_) => const TodayPage(),
      //     ),
      //     (route) => route.isFirst);
    });
    super.initState();
  }

  @override
  void dispose() {
    //dispose off streams
    AwesomeNotifications().actionSink.close();
    AwesomeNotifications().createdSink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 8, right: 8, left: 8),
                child: Row(
                  children: [
                    const SizedBox(width: 2),
                    Text(
                      "Reminders",
                      style: GoogleFonts.roboto(
                        fontSize: 40,
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 10),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: GestureDetector(
              //     onTap: () async {
              //       createNotification();

              //       //TODO: Add snackbars to notify user
              //     },
              //     child: Text(
              //       "Simple Notifications",
              //       style: GoogleFonts.roboto(
              //         fontSize: 18,
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    NotificationWeekAndTime pickedSchedule =
                        await pickSchedule(context);
                    if (pickedSchedule != null) {
                      createDrinkReminder(pickedSchedule);
                    }
                    //TODO: Add snackbars to notify user
                  },
                  child: Text(
                    "Schedule Notifications",
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    cancelScheduledNotifications();

                    //TODO: Add snackbars to notify user
                  },
                  child: Text(
                    "Cancel All Notifications",
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
