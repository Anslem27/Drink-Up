import 'package:drink_up/Settings/Widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../Models/app_state.dart';
import '../../util/utilities.dart';
import '../home/widgets/drink_bottomsheet.dart';
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
                        //TODO Add a suitable Image within the header,hopefuly dynamic.
                        Image.asset(
                          "assets/icons/calendar.png",
                          height: 40,
                          width: 40,
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width / 23),
                        Text(
                          "Today",
                          style: GoogleFonts.nunitoSans(
                            fontSize: 38,
                            color: Theme.of(context).focusColor,
                          ),
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.only(right: 25.0),
                          child: TodaysHistory(),
                        ),
                      ],
                    ),
                  ),
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
        var historyText = "You hav'nt drunk\nanything today!";
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
            /* 
            DateFormat('HH:mm a')
            formats am and pm
             
             */
            historyText = "${entry.amount} ml at  " +
                DateFormat('HH:mm a')
                    .format(DateTime.fromMillisecondsSinceEpoch(entry.date)) +
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

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 5.0),
                    child: Icon(Icons.wine_bar_outlined, size: 28),
                  ),
                  Text(
                    "GLANCE",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: IconButton(
                      splashRadius: 22,
                      //TODO: Maybe move this to the faq page.
                      onPressed: () => showDialog(
                        context: context,
                        builder: (_) => InfoDialog(
                          headercolor: Colors.redAccent,
                          header: "My Glance",
                          buttontext: "Ok",
                          onpressed: () => Navigator.pop(context),
                          subtitletext:
                              "Your glance features all your drink history up to three records with there corresponding time intervals",
                        ),
                      ),
                      icon: const Icon(Icons.info_outline_rounded, size: 25),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                historyText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
