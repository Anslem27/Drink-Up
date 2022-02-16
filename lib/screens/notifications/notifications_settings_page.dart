import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Models/app_state.dart';
import '../../actions/settings_actions.dart';
typedef OnSaveCallback = Function(
    {bool enabled, TimeOfDay from, TimeOfDay to, int interval});

class NotificationsSettingsPage extends StatefulWidget {
  const NotificationsSettingsPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NotificationsSettingsPageState();
  }
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

class _NotificationsSettingsPageState extends State<NotificationsSettingsPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        Positioned(
          bottom: 0.0,
          height: 160.0,
          child: SizedBox(
            width: size.width,
            height: 160.0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.3, 0.7],
                  colors: [Colors.white.withOpacity(0.0), Colors.white],
                ),
              ),
            ),
          ),
        ),
        StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, state) {
            return Scaffold(
              body: SafeArea(
                  bottom: false,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 8, right: 8, left: 8),
                        child: Row(
                          children: [
                            const SizedBox(width: 2),
                            Text(
                              "Notifications",
                              style: GoogleFonts.raleway(
                                fontSize: 30,
                                color: Theme.of(context).focusColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, bottom: 16.0),
                          child: StoreConnector<AppState, OnSaveCallback>(
                            converter: (store) {
                              return ({enabled, from, to, interval}) {
                                var settings = store.state.settings.copyWith(
                                    notificationsEnabled: enabled,
                                    notificationsFromTime: from,
                                    notificationsToTime: to,
                                    notificationsInterval: interval);
                                store.dispatch(
                                    SaveNotificationSettingsAction(settings));
                              };
                            },
                            builder: (context, callback) {
                              return Container(
                                //height: MediaQuery.of(context).size.height / 20,
                                decoration: BoxDecoration(
                                  color: Colors.green[100],
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 16.0),
                                      child: Row(
                                        children: <Widget>[
                                          const Expanded(
                                            child: Text('Notifications'),
                                          ),
                                          Switch(
                                            value: state
                                                .settings.notificationsEnabled,
                                            onChanged: (value) {
                                              callback(enabled: value);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: GestureDetector(
                                        onTap: () async {
                                          var picked = await showTimePicker(
                                              context: context,
                                              initialTime: state.settings
                                                  .notificationsFromTime);
                                          if (picked != null &&
                                              picked !=
                                                  state.settings
                                                      .notificationsFromTime) {
                                            callback(from: picked);
                                          }
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            const Expanded(
                                              child: Text('From'),
                                            ),
                                            Text(
                                              state.settings
                                                  .notificationsFromTime
                                                  .format(context),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: GestureDetector(
                                        onTap: () async {
                                          var picked = await showTimePicker(
                                              context: context,
                                              initialTime: state.settings
                                                  .notificationsToTime);
                                          if (picked != null &&
                                              picked !=
                                                  state.settings
                                                      .notificationsToTime) {
                                            callback(to: picked);
                                          }
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            const Expanded(
                                              child: Text('To'),
                                            ),
                                            Text(
                                              state.settings.notificationsToTime
                                                  .format(context),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: GestureDetector(
                                        onTap: () async {
                                          var picked = await showMinutesPicker(
                                              context: context,
                                              initialMinutes: state.settings
                                                  .notificationsInterval);
                                          if (picked != null &&
                                              picked !=
                                                  state.settings
                                                      .notificationsInterval) {
                                            callback(interval: picked);
                                          }
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            const Expanded(
                                              child: Text('Interval'),
                                            ),
                                            Text(
                                              _formatMinutes(state.settings
                                                  .notificationsInterval),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  )),
            );
          },
        )
      ],
    );
  }
}

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

const double _kTimePickerWidthPortrait = 328.0;
const double _kTimePickerHeightPortrait = 256.0;

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
              child: Text(localizations.cancelButtonLabel),
              onPressed: _handleCancel),
          ElevatedButton(
              child: Text(localizations.okButtonLabel), onPressed: _handleOk),
        ],
      ),
    );

    final pickerAndActions = Container(
      color: theme.dialogBackgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
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
    );

    final Dialog dialog = Dialog(
        child: SizedBox(
            width: _kTimePickerWidthPortrait,
            height: _kTimePickerHeightPortrait,
            child: pickerAndActions));

    return Theme(
      data: theme.copyWith(
        dialogBackgroundColor: Colors.transparent,
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
