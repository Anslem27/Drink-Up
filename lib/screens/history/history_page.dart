import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../managers/database/drink_history.dart';
import '../../model/app_state.dart';
import '../../util/utils.dart';
import '../../widgets/container_wrapper/container_wrapper.dart';
import 'history_manager.dart';
import 'widgets/history_lists.dart';

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

  final Color _color = Colors.transparent;
  final Color _selectedColor = Colors.white;

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

  List<Widget> _buildStats(List<DrinkHistoryEntry> entries) {
    List<DrinkHistoryEntry> currentEntries =
        _currentEntries(entries, _currentIndex);
    double summary = currentEntries.fold(0.0, (t, e) => t + e.amount);

    List<Widget> statWidgets = [
      Expanded(
          child: HistoryStatsText(
        "SUMMARY",
        summary,
        const Color(0xFF6fa1ea),
        unit: 'ml',
      )),
    ];

    if (_currentIndex == 0) {
      statWidgets.add(
        Expanded(
            child: HistoryStatsText(
                "AVERAGE\nDRINK",
                currentEntries.isNotEmpty
                    ? summary / currentEntries.length
                    : 0.0,
                const Color(0xFFc7d0df),
                unit: 'ml')),
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
            child: HistoryStatsText(
                "AVERAGE\nA DAY", avg, const Color(0xFFc7d0df),
                unit: 'ml')),
      );
    }

    statWidgets.add(
      Expanded(
          child: HistoryStatsText("TOTAL\nCUPS",
              currentEntries.length.toDouble(), const Color(0xFFf5bad3))),
    );

    return statWidgets;
  }

  Widget _tabBarButton(String title, int index) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            primary: _currentIndex == index ? _selectedColor : _color,
          ),
          onPressed: () {
            _onItemTapped(index);
          },
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: _currentIndex == index
                    ? const Color(0xFF6fa1ea)
                    : _selectedColor),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return StoreConnector<AppState, List<DrinkHistoryEntry>>(
      converter: (store) => store.state.drinksHistory,
      builder: (context, entries) {
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
            SafeArea(
              bottom: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        _tabBarButton('Today', 0),
                        _tabBarButton('7 days', 1),
                        _tabBarButton('30 days', 2),
                        _tabBarButton('365 days', 3),
                      ],
                    ),
                  ),
                  Expanded(
                    child: HistoryLists(
                      tabController: _tabController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ContainerWrapper(
                      widthScale: 1.0,
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
          ],
        );
      },
    );
  }
}

class HistoryStatsText extends StatelessWidget {
  final String title;
  final double value;
  final String unit;
  final Color titleColor;

  const HistoryStatsText(this.title, this.value, this.titleColor,
      {Key key, this.unit})
      : super(key: key);

  List<Widget> _buildTexts() {
    List<Widget> widgets = [
      Text(
        Utils.formatNumberWithShortcuts(value, unit != null ? 2 : 0),
        textAlign: TextAlign.left,
        style: const TextStyle(
            color: Color(0xFF7f8ca1),
            fontSize: 18.0,
            fontWeight: FontWeight.w400),
      ),
    ];

    if (unit != null) {
      widgets.add(
        Text(
          unit,
          textAlign: TextAlign.left,
          style: const TextStyle(
              color: Color(0xFF7f8ca1),
              fontSize: 14.0,
              fontWeight: FontWeight.w300),
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
    String readableDate = DateFormat('EEE, M/d/y').format(date);
    String readableTime = DateFormat('HH:mm').format(date);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  readableDate,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      fontSize: 15.0, fontWeight: FontWeight.w600),
                ),
                Text(
                  readableTime,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      fontSize: 13.0, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(
              '$amount ml',
              textAlign: TextAlign.right,
              style: const TextStyle(
                  color: Color(0xFF6fa1ea),
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
