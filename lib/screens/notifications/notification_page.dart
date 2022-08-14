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
  List<NotificationModel> currentNotifications;

  //list active notifications
  showScheduledNotification() async {
    currentNotifications =
        await AwesomeNotifications().listScheduledNotifications();
    return currentNotifications;
  }

  @override
  void initState() {
    showScheduledNotification();
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

    // AwesomeNotifications().actionStream.listen((event) {
    //   //decrement IOS notification count
    //   if (event.channelKey == "basic_channel" && Platform.isIOS) {
    //     AwesomeNotifications().getGlobalBadgeCounter().then(
    //         (value) => AwesomeNotifications().setGlobalBadgeCounter(value - 1));
    //   }

    //   //!push user notifications to today Page
    //   // Navigator.pushAndRemoveUntil(
    //   //     context,
    //   //     CupertinoPageRoute(
    //   //       builder: (_) => const TodayPage(),
    //   //     ),
    //   //     (route) => route.isFirst);
    // });
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
                    //TODO: Add snackbars for confirmation
                  },
                  child: Text(
                    "Cancel All Notifications",
                    style: GoogleFonts.roboto(fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child:
                    //future builder to show notifications
                    FutureBuilder(
                  future: showScheduledNotification(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: currentNotifications.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(
                                currentNotifications[index]
                                    .schedule
                                    .createdDate,
                                style: GoogleFonts.roboto(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                /* ListView.builder(
                  itemCount: currentNotifications?.length ?? 0,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          const Icon(Icons.circle),
                          Text(
                            currentNotifications[index].schedule.createdDate,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    );
                  },
                ), */
              )
            ],
          ),
        ),
      ),
    );
  }
}
