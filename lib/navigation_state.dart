//import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'util/utils.dart';
import 'screens/history/history_page.dart';
import 'screens/notifications/notifications_settings_page.dart';
import 'screens/settings/settings_page.dart';
import 'screens/today/today_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  /* static const MobileAdTargetingInfo _targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['water', 'health', 'drinking', 'fit'],
    childDirected: false,
    testDevices: <String>[],
  );
 */
  /*  BannerAd _bannerAd;

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.banner,
      targetingInfo: _targetingInfo,
    );
  } */

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    /* FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    _bannerAd = createBannerAd()
      ..load()
      ..show(anchorOffset: 25, anchorType: AnchorType.top); */
  }

  /* @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _bannerAd?.dispose();
    super.dispose();
  } */

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
    const NotificationsSettingsPage(),
    const SettingsPage(),
  ];

  int currentindex = 0;
  void indexChanger(int value) {
    setState(() {
      currentindex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final iconThemeColor = Theme.of(context).hoverColor;
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    alignment: AlignmentDirectional.topStart,
                    image: AssetImage('assets/background/top-background.png'),
                    fit: BoxFit.fitWidth),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: appBody[currentindex],
            ),
          ],
        ),
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: Theme.of(context).primaryColor,
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
                    Icons.home_rounded,
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
                  label: "Home"),
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
                  label: "History"),
              NavigationDestination(
                  selectedIcon: Icon(
                    Icons.notifications,
                    size: 30,
                    semanticLabel: 'Notifications',
                    color: iconThemeColor,
                  ),
                  icon: Icon(
                    Icons.notifications_outlined,
                    size: 30,
                    semanticLabel: 'Notifications',
                    color: iconThemeColor,
                  ),
                  label: "Notifications"),
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
                  label: "Profile"),
            ],
          ),
        ),
      ),
    );
  }
}
