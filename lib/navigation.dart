
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'screens/profile/profile_page.dart';
import 'util/utilities.dart';
import 'screens/history/history_page.dart';
import 'screens/today/today_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  DateTime lastUpdated;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (lastUpdated != null && !Utils.isToday(lastUpdated)) {
        setState(() {
          lastUpdated = DateTime.now();
        });
      }
    } else if (state == AppLifecycleState.paused) {
      lastUpdated = DateTime.now();
    }
  }

  final appBody = [
    const TodayPage(),
    const HistoryPage(),
    const ProfilePage(),
  ];

  int currentindex = 0;

  @override
  Widget build(BuildContext context) {
    @override
    final iconThemeColor = Theme.of(context).hoverColor;
    return Scaffold(
      body: SafeArea(child: appBody[currentindex]),
      bottomNavigationBar: navigationDestinations(context, iconThemeColor),
    );
  }

  navigationDestinations(BuildContext context, Color iconThemeColor) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        indicatorColor: Theme.of(context).highlightColor,
        labelTextStyle: MaterialStateProperty.all(
          const TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      child: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: currentindex,
        onDestinationSelected: (index) {
          setState(() {
            currentindex = index;
          });
        },
        height: 55,
        destinations: [
          NavigationDestination(
            selectedIcon: Icon(
              Iconsax.home,
              semanticLabel: 'Home',
              size: 33,
              color: iconThemeColor,
            ),
            icon: Icon(
              Iconsax.home,
              semanticLabel: 'Home',
              size: 33,
              color: iconThemeColor,
            ),
            label: "Home",
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.history_rounded,
              semanticLabel: 'History',
              size: 29,
              color: iconThemeColor,
            ),
            icon: Icon(
              Iconsax.activity,
              semanticLabel: 'History',
              size: 29,
              color: iconThemeColor,
            ),
            label: "History",
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Iconsax.user,
              size: 30,
              semanticLabel: 'Profile',
              color: iconThemeColor,
            ),
            icon: Icon(
              Iconsax.user,
              size: 30,
              semanticLabel: 'Profile',
              color: iconThemeColor,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
