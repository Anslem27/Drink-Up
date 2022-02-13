import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../managers/database/drink_history.dart';
import '../../Models/app_state.dart';
import '../../util/utilities.dart';
import '../../widgets/container_wrapper/container_wrapper.dart';
import 'history_manager.dart';
import 'widgets/history_widgets.dart';

typedef OnDrinkEntryRemovedCallback = Function(DrinkHistoryEntry entry);

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HistoryPageState();
  }
}

class _HistoryPageState extends State<HistoryPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _currentIndex = 0;

  //? WaterLike blue colors
  final Color color = Colors.blue[200];
  final Color selectedColor = Colors.blueAccent;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(vsync: this, length: 4, initialIndex: _currentIndex);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    _tabController.animateTo(index);
    setState(() {
      _currentIndex = index;
    });
  }

  List<DrinkHistoryEntry> _currentEntries(
      List<DrinkHistoryEntry> entries, int index) {
    DateTime today = DateTime.now();

    List<DrinkHistoryEntry> currentEntries = [];
    if (index == 0) {
      currentEntries = entries
          .where((entry) => HistoryManager.manager
              .isToday(DateTime.fromMillisecondsSinceEpoch(entry.date)))
          .toList();
    } else if (index == 1) {
      Duration week = const Duration(days: 7);
      currentEntries = entries
          .where((entry) =>
              today
                  .difference(DateTime.fromMillisecondsSinceEpoch(entry.date))
                  .compareTo(week) <
              1)
          .toList();
    } else if (index == 2) {
      Duration month = const Duration(days: 30);
      currentEntries = entries
          .where((entry) =>
              today
                  .difference(DateTime.fromMillisecondsSinceEpoch(entry.date))
                  .compareTo(month) <
              1)
          .toList();
    } else if (index == 3) {
      Duration year = const Duration(days: 365);
      currentEntries = entries
          .where((entry) =>
              today
                  .difference(DateTime.fromMillisecondsSinceEpoch(entry.date))
                  .compareTo(year) <
              1)
          .toList();
    }

    currentEntries.sort((a, b) => b.date.compareTo(a.date));
    return currentEntries;
  }

  List<Widget> _buildStats(entries) {
    List<DrinkHistoryEntry> currentEntries =
        _currentEntries(entries, _currentIndex);
    double summary = currentEntries.fold(0.0, (t, e) => t + e.amount);

    List<Widget> statWidgets = [
      Expanded(
        child: HistorySummaryText(
          "TOTAL\n(Per time frame)",
          summary,
          Colors.white,
          unit: 'ml',
        ),
      ),
    ];

    if (_currentIndex == 0) {
      statWidgets.add(
        Expanded(
          child: HistorySummaryText(
              "AVERAGE Intake(ml)",
              currentEntries.isNotEmpty ? summary / currentEntries.length : 0.0,
              Colors.black,
              unit: 'ml'),
        ),
      );
    } else {
      var avg = 0.0;
      if (currentEntries.isNotEmpty) {
        currentEntries.sort((a, b) => b.date.compareTo(a.date));
        var firstDay =
            DateTime.fromMillisecondsSinceEpoch(currentEntries.first.date);

        var lastDay =
            DateTime.fromMillisecondsSinceEpoch(currentEntries.last.date);

        var days = firstDay.difference(lastDay).inDays + 1;

        avg = summary / days;
      }
      statWidgets.add(
        Expanded(
          child: HistorySummaryText("AVERAGE\nA DAY", avg, Colors.black,
              unit: 'ml'),
        ),
      );
    }

    statWidgets.add(
      Expanded(
        child: HistorySummaryText(
          "TOTAL\nCUPS",
          currentEntries.length.toDouble(),
          Colors.white,
        ),
      ),
    );

    return statWidgets;
  }

  Widget tabButton(String title, int index) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            primary: _currentIndex == index ? selectedColor : color,
          ),
          onPressed: () {
            _onItemTapped(index);
          },
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
              color: _currentIndex == index
                  ? Colors.white
                  : const Color.fromARGB(255, 110, 100, 246),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<DrinkHistoryEntry>>(
      converter: (store) => store.state.drinksHistory,
      builder: (context, entries) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 8, right: 8, left: 8),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        tooltip: "History",
                        icon: const Icon(
                          Icons.history_rounded,
                          size: 30,
                        ),
                        splashRadius: 25,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        "History",
                        style: GoogleFonts.raleway(
                          fontSize: 30,
                          color: Theme.of(context).focusColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      tabButton('Today', 0),
                      tabButton('Last week', 1),
                      tabButton('Last month', 2),
                      tabButton('Past year', 3),
                    ],
                  ),
                ),
                Expanded(
                  child: HistoryLists(
                    tabController: _tabController,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  height: MediaQuery.of(context).size.height / 8,
                  decoration: BoxDecoration(
                    color: Colors.blue[400],
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: _buildStats(entries),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class HistorySummaryText extends StatelessWidget {
  final String title;
  final double value;
  final String unit;
  final Color titleColor;

  const HistorySummaryText(this.title, this.value, this.titleColor,
      {Key key, this.unit})
      : super(key: key);

  List<Widget> _buildTexts() {
    List<Widget> widgets = [
      Text(
        Utils.formatNumberWithShortcuts(value, unit != null ? 2 : 0),
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 19.0,
        ),
      ),
    ];

    if (unit != null) {
      widgets.add(
        Text(
          unit,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: 14.0,
          ),
        ),
      );
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: titleColor, fontWeight: FontWeight.w600, fontSize: 15.0),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: _buildTexts(),
            ),
          ),
        ],
      ),
    );
  }
}

class DrinkHitoryListItem extends StatelessWidget {
  final int amount;
  final DateTime date;

  const DrinkHitoryListItem(this.amount, this.date, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String readableDate = DateFormat('   EEEEEE\n d-M-y').format(date);
    String readableTime = DateFormat('HH:mm').format(date);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height / 10,
        margin: const EdgeInsets.only(left: 12, right: 12),
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 7.5, top: 9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      readableDate,
                      style: const TextStyle(
                        fontSize: 19.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "At $readableTime",
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: Text(
                  '$amount ml',
                  style: const TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
