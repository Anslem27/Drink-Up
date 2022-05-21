import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'screens/profile/profile_page.dart';
import 'util/utilities.dart';
import 'screens/history/history_page.dart';
//import 'screens/notifications/notifications_settings_page.dart';
import 'screens/today/today_page.dart';



//FIXME: Most databases dont work, due to future or stuff
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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

  DateTime? lastUpdated;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (lastUpdated != null && !Utils.isToday(lastUpdated!)) {
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
    final iconThemeColor = Theme.of(context).hoverColor;
    return Scaffold(
      body: appBody[currentindex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentindex,
        onTap: (value) {
          setState(() {
            currentindex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                "assets/svg/home.svg",
                height: 25,
                width: 25,
                color: iconThemeColor,
              ),
              icon: SvgPicture.asset(
                "assets/svg/home.svg",
                height: 25,
                width: 25,
                color: iconThemeColor,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                "assets/svg/time-past.svg",
                color: iconThemeColor,
              ),
              icon: SvgPicture.asset(
                "assets/svg/time-past.svg",
                color: iconThemeColor,
              ),
              label: "History"),
          /* BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                "assets/svg/marker.svg",
              ),
              icon: SvgPicture.asset("assets/svg/time-past.svg"),
              label: "Notifications"), */
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              "assets/svg/user.svg",
              height: 25,
              width: 25,
              color: iconThemeColor,
            ),
            icon: SvgPicture.asset(
              "assets/svg/user.svg",
              height: 25,
              width: 25,
              color: iconThemeColor,
            ),
            label: "Profile",
          ),
        ],
      ),
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
              CupertinoIcons.home,
              semanticLabel: 'Home',
              size: 33,
              color: iconThemeColor,
            ),
            icon: Icon(
              Icons.home_outlined,
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
              Icons.history,
              semanticLabel: 'History',
              size: 29,
              color: iconThemeColor,
            ),
            label: "History",
          ),
          /*  NavigationDestination(
            selectedIcon: Icon(
              Icons.notifications,
              size: 30,
              semanticLabel: 'Reminders',
              color: iconThemeColor,
            ),
            icon: Icon(
              Icons.notifications_outlined,
              size: 30,
              semanticLabel: 'Reminders',
              color: iconThemeColor,
            ),
            label: "Reminders",
          ), */
          NavigationDestination(
            selectedIcon: Icon(
              Icons.account_circle_sharp,
              size: 30,
              semanticLabel: 'Profile',
              color: iconThemeColor,
            ),
            icon: Icon(
              Icons.account_circle_outlined,
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


//indicatorColor: Theme.of(context).highlightColor,