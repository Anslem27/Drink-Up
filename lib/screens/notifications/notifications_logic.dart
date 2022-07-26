import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:drink_up/screens/notifications/notification_utils.dart';

Future<void> createNotification() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'basic_channel',
      title: 'Hello there',
      body: 'Its time to have a drink',
      notificationLayout: NotificationLayout.Default,
    ),
  );
}

Future<void> createDrinkReminder(
    NotificationWeekAndTime notificationSchedule) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'scheduled_channel',
      title: 'Drink Up !',
      body: 'Its time to have your scheduled drink',
      notificationLayout: NotificationLayout.Default,
    ),
    actionButtons: [
      NotificationActionButton(key: 'MARK_DONE', label: 'Mark Done'),
    ],
    schedule: NotificationCalendar(
      weekday: notificationSchedule.dayOfTheWeek,
      hour: notificationSchedule.timeOfDay.hour,
      minute: notificationSchedule.timeOfDay.minute,
      second: 0,
      millisecond: 0,
      repeats: true,
    ),
  );
}



Future<void> cancelScheduledNotifications() async {
  await AwesomeNotifications().cancelAllSchedules();
}
