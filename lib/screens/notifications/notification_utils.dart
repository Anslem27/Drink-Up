import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

class NotificationWeekAndTime {
  final int dayOfTheWeek;
  final TimeOfDay timeOfDay;

  NotificationWeekAndTime({
    @required this.dayOfTheWeek,
    @required this.timeOfDay,
  });
}

//per day
Future<NotificationWeekAndTime> pickSchedule(
  BuildContext context,
) async {
  List<String> weekdays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];
  TimeOfDay timeOfDay;
  DateTime now = DateTime.now();
  int selectedDay;

  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'I want to be reminded every:',
            textAlign: TextAlign.center,
          ),
          content: Wrap(
            alignment: WrapAlignment.center,
            spacing: 3,
            children: [
              for (int index = 0; index < weekdays.length; index++)
                ElevatedButton(
                  onPressed: () {
                    selectedDay = index + 1;
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color(0xff7fffd4),
                    ),
                  ),
                  child: Text(
                    weekdays[index],
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                    ),
                  ),
                ),
            ],
          ),
        );
      });

  if (selectedDay != null) {
    timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(
          now.add(
            const Duration(minutes: 1),
          ),
        ),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData(
              colorScheme: const ColorScheme.light(
                primary: Color(0xff7fffd4),
              ),
            ),
            child: child,
          );
        });

    if (timeOfDay != null) {
      return NotificationWeekAndTime(
          dayOfTheWeek: selectedDay, timeOfDay: timeOfDay);
    }
  }
  return null;
}

String _formatMinutes(int minutes) {
  if (minutes < 60) {
    return '$minutes min';
  } else {
    var hours = minutes ~/ 60;
    var minutesLeft = minutes - hours * 60;

    var finalPhrase = '$hours hr';

    if (minutesLeft > 0) {
      finalPhrase += ' $minutesLeft min';
    }

    return finalPhrase;
  }
}

//TODO: per minute
Future<int> showMinutesPicker(
    {@required BuildContext context, @required int initialMinutes}) async {
  assert(context != null);
  assert(initialMinutes != null);

  return await showDialog<int>(
    context: context,
    builder: (BuildContext context) => const MinutesPickerDialog(),
  );
}

class MinutesPickerDialog extends StatefulWidget {
  const MinutesPickerDialog({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MinutesPickerDialogState();
  }
}

class _MinutesPickerDialogState extends State<MinutesPickerDialog> {
  int _selectedMinutes;

  @override
  void initState() {
    super.initState();
    _selectedMinutes = 30;
  }

  final values = [30, 45, 60, 75, 90, 120, 150, 180, 210, 240, 270, 300];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);

    final rows = values
        .map<Widget>((value) => Center(
              child: Text(_formatMinutes(value)),
            ))
        .toList();

    final Widget actions = ButtonBarTheme(
      data: const ButtonBarThemeData(),
      child: ButtonBar(
        children: <Widget>[
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(localizations.cancelButtonLabel),
              onPressed: _handleCancel),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Text(localizations.okButtonLabel),
            onPressed: _handleOk,
          ),
        ],
      ),
    );

    final Dialog dialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 250,
              child: CupertinoPicker(
                backgroundColor: theme.dialogBackgroundColor,
                children: rows,
                itemExtent: 32.0,
                onSelectedItemChanged: _handleMinutesChanged,
              ),
            ),
            actions
          ],
        ),
      ),
    );

    return Theme(
      data: theme.copyWith(
        dialogBackgroundColor: theme.dialogBackgroundColor,
      ),
      child: dialog,
    );
  }

  void _handleMinutesChanged(int index) {
    setState(() {
      _selectedMinutes = values[index];
    });
  }

  void _handleCancel() {
    Navigator.pop(context);
  }

  void _handleOk() {
    Navigator.pop(context, _selectedMinutes);
  }
}
