import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../Models/app_state.dart';
import '../../util/utilities.dart';
import '../home/widgets/drink_menu.dart';
import '../home/widgets/water_progress.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      left: 8,
                    ),
                    child: Row(
                      children: [
                        //TODO Add a suitable Image within the header.
                        Text(
                          "TODAY",
                          style: GoogleFonts.raleway(
                            fontSize: 30,
                            color: Theme.of(context).focusColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //? TODO Add drink history somewhere else more vibrant.
                  /* const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.0),
                    child: TodaysHistory(),
                  ), */
                  const SizedBox(
                    child: WaterProgress(),
                  ),
                ],
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Padding(
              padding: EdgeInsets.only(bottom: 48.0),
              child: Center(
                child: DrinkBottomSheet(),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class TodaysHistory extends StatelessWidget {
  const TodaysHistory({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        var historyText = '\nYou have not drunk anything today yet!\n';
        var todayEntries = state.drinksHistory
            .where((entry) => Utils.isToday(
                  DateTime.fromMillisecondsSinceEpoch(entry.date),
                ))
            .toList();

        if (todayEntries.isNotEmpty) {
          todayEntries.sort(
            (a, b) => b.date.compareTo(a.date),
          );
          var i = 0;
          historyText = '';
          for (var entry in todayEntries) {
            historyText = DateFormat('HH:mm').format(
                  DateTime.fromMillisecondsSinceEpoch(entry.date),
                ) +
                ' - ${entry.amount} ml' +
                historyText;
            i++;

            if (i < 3) {
              historyText = '\n' + historyText;
            } else {
              break;
            }
          }

          if (i < 3) {
            for (var index = 1; index < 3 - i; index++) {
              historyText = '\n' + historyText;
            }
          }
        }

        return Text(
          historyText,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.normal,
          ),
        );
      },
    );
  }
}
