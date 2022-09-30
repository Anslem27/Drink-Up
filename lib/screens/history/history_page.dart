import 'dart:math';

import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import '../../managers/database/drink_history.dart';
import '../../Models/app_state.dart';
import '../../util/utilities.dart';
import 'history_manager.dart';
import 'widgets/history_widgets.dart';

List randomImage = [
  "assets/illustrations/cyborg-chart-1.png",
  "assets/illustrations/cyborg-chart-10.png",
  "assets/illustrations/cyborg-art.png",
];
var randomSummaryImage = Random();
var randomImageDissolver =
    randomImage[randomSummaryImage.nextInt(randomImage.length)];

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
  final Color color = const Color(0xffa4dded);
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
          "TOTAL",
          summary,
          Theme.of(context).focusColor,
          unit: 'ml',
        ),
      ),
    ];

    if (_currentIndex == 0) {
      statWidgets.add(
        Expanded(
          child: HistorySummaryText(
            "AVERAGE INTAKE",
            currentEntries.isNotEmpty ? summary / currentEntries.length : 0.0,
            Theme.of(context).focusColor,
            unit: 'ml',
          ),
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
          child: HistorySummaryText(
            "AVERAGE\nA DAY",
            avg,
            Theme.of(context).focusColor,
            unit: 'ml',
          ),
        ),
      );
    }

    statWidgets.add(
      Expanded(
        child: HistorySummaryText(
          "TOTAL\nCUPS",
          currentEntries.length.toDouble(),
          Theme.of(context).focusColor,
        ),
      ),
    );

    return statWidgets;
  }

  Widget tabButton(String respectiveTitle, int index) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ), backgroundColor: _currentIndex == index ? selectedColor : color,
          ),
          onPressed: () {
            _onItemTapped(index);
          },
          child: Text(
            respectiveTitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.nunitoSans(
              color: _currentIndex == index
                  ? Colors.white
                  : const Color.fromARGB(255, 14, 75, 179),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, List<DrinkHistoryEntry>>(
        converter: (store) => store.state.drinksHistory,
        builder: (context, entries) {
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 8, right: 8, left: 8, top: 8),
                  child: Row(
                    children: [
                      const SizedBox(width: 2),
                      Text(
                        "History",
                        style: GoogleFonts.nunitoSans(
                          fontSize: 40,
                          color: Theme.of(context).focusColor,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "My\nSummary",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          fontSize: 19,
                          color: Theme.of(context).focusColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: IconButton(
                          onPressed: () => showSlidingBottomSheet(
                            context,
                            builder: (_) => SlidingSheetDialog(
                              duration: const Duration(milliseconds: 500),
                              cornerRadius: 16,
                              snapSpec: const SnapSpec(
                                initialSnap: 0.7,
                                snappings: [0.7, 0.9],
                              ),
                              builder: (_, SheetState state) {
                                return summaryBottomSheet(entries);
                              },
                            ),
                          ),
                          tooltip: "Summary",
                          icon: Icon(
                            Iconsax.bookmark,
                            size: 30,
                            color: Theme.of(context).focusColor,
                            semanticLabel: "Summary",
                          ),
                          splashRadius: 25,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              ],
            ),
          );
        },
      ),
    );
  }

  Widget summaryBottomSheet(List<DrinkHistoryEntry> entries) {
    return Material(
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 8,
                width: MediaQuery.of(context).size.width / 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.blue[300],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.5),
              child: Image.asset(
                randomImageDissolver,
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width / 2.5,
              ),
            ),
            Text(
              "Summary",
              style: GoogleFonts.nunitoSans(
                color: Theme.of(context).focusColor,
                fontSize: 28,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: _buildStats(entries),
              ),
            ),
          ],
        ),
      ),
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
    String readableDay = DateFormat('EEEEEE').format(date);
    String drinkdate = DateFormat('d/M/y').format(date);
    String readableTime = DateFormat('HH:mm a').format(date);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.only(left: 2, right: 2),
        decoration: BoxDecoration(
          color: Theme.of(context).highlightColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 4, top: 9),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width / 35),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(4.5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.calendar_today_rounded,
                                size: 25,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                readableDay,
                                style: const TextStyle(
                                  fontSize: 19.5,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 3),
                        Padding(
                          padding: const EdgeInsets.all(4.5),
                          child: Row(
                            children: [
                              const Icon(
                                Iconsax.calendar,
                                size: 25,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                drinkdate,
                                style: const TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //? Dynamic water intake icon.
                    getImage(amount),
                    const SizedBox(width: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '$amount ml',
                          style: const TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 22.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "At $readableTime",
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //? Fetches image per water entry.
  getImage(int amount) {
    switch (amount) {
      case 250:
        return Image.asset(
          "assets/bottle/glass-of-water.png",
          height: 45,
          width: 45,
        );
      case 300:
        return Image.asset(
          "assets/bottle/mineral-water.png",
          height: 45,
          width: 45,
        );
      case 500:
        return Image.asset(
          "assets/bottle/plastic-bottle-blue.png",
          height: 45,
          width: 45,
        );
      case 501:
        return Image.asset(
          "assets/bottle/big-juice.png",
          height: 45,
          width: 45,
        );
      case 251:
        return Image.asset(
          "assets/bottle/small-juice.png",
          height: 45,
          width: 45,
        );
      case 301:
        return Image.asset(
          "assets/bottle/medium-juice.png",
          height: 45,
          width: 45,
        );
      default:
        return Image.asset(
          "assets/icons/water.png",
          height: 45,
          width: 45,
        );
    }
  }
}
