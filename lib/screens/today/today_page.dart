import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import '../../model/app_state.dart';
import '../../util/utils.dart';
import '../../widgets/Reusable Widgets/shadow_text.dart';
import '../home/widgets/drink_menu.dart';
import '../home/widgets/water_progress.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ShadowText(
                    'TODAY',
                    shadowColor: Colors.black.withOpacity(0.15),
                    offsetX: 3.0,
                    offsetY: 3.0,
                    blur: 3.0,
                    style: const TextStyle(
                        color: Color(0xBEffffff),
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: _TodayHistory(),
                ),
                const Expanded(
                  child: WaterProgress(),
                ),
              ],
            ),
          ),
        ),
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Padding(
              padding: EdgeInsets.only(bottom: 48.0),
              child: Center(
                child: DrinkMenu(),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class _TodayHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        var historyText = '\nYou have not drunk anything today yet!\n';
        var todayEntries = state.drinksHistory
            .where((entry) =>
                Utils.isToday(DateTime.fromMillisecondsSinceEpoch(entry.date)))
            .toList();

        if (todayEntries.length > 0) {
          todayEntries.sort((a, b) => b.date.compareTo(a.date));
          var i = 0;
          historyText = '';
          for (var entry in todayEntries) {
            historyText = DateFormat('HH:mm')
                    .format(DateTime.fromMillisecondsSinceEpoch(entry.date)) +
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

        return ShadowText(
          historyText,
          shadowColor: Colors.black.withOpacity(0.15),
          offsetX: 3.0,
          offsetY: 3.0,
          blur: 3.0,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.normal),
        );
      },
    );
  }
}
