import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../util/utils.dart';
import '../../widgets/shadow/shadow_icon.dart';
import '../history/history_page.dart';
import '../notifications/notifications_settings_page.dart';
import '../settings/settings_page.dart';
import '../today/today_page.dart';

// typedef OnDrinkAddedCallback = Function(Drink drink);

// class HomePage extends StatelessWidget {
//   final Store<AppState> store;

//   HomePage(this.store);

//   @override
//   State<StatefulWidget> createState() {
//     return _HomePageState();
//   }
// }

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  static const MobileAdTargetingInfo _targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['water', 'health', 'drinking', 'fit'],
    childDirected: false,
    testDevices: <String>[], // Android emulators are considered test devices
  );

  BannerAd _bannerAd;

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.banner,
      targetingInfo: _targetingInfo,
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    _bannerAd = createBannerAd()
      ..load()
      ..show(anchorOffset: 25, anchorType: AnchorType.top);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _bannerAd?.dispose();
    super.dispose();
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

// HomePage() {
  //   _initQuickActions();
  // }

  // void _initQuickActions() {
  //   final QuickActions quickActions = const QuickActions();
  //   quickActions.initialize((String shortcutType) {
  //     // StoreConnector<AppState, AppState>(converter: (Store store) {}, builder: (BuildContext context, AppState vm) {},);
  //     if (shortcutType == 'add_small_water') {
  //       Drink drink = Drink.water();
  //       var entry = DrinkHistoryEntry();
  //       entry.amount = drink.amount;
  //       entry.date = DateTime.now().millisecondsSinceEpoch;
  //       // store.dispatch(AddDrinkToHistoryAction(entry));
  //     }
  //   });

  //   quickActions.setShortcutItems(<ShortcutItem>[
  //     const ShortcutItem(
  //       type: 'add_small_water',
  //       localizedTitle: 'Small Water (250 ml)',
  //     ),
  //   ]);
  // }

  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return const TodayPage();
      case 1:
        return const HistoryPage();
      case 2:
        return const NotificationsSettingsPage();
      case 3:
        return const SettingsPage();
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ShadowIcon(
              Icons.home,
              offsetX: 0.0,
              offsetY: 0.0,
              blur: 3.0,
              shadowColor: Colors.black.withOpacity(0.25),
            ),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: ShadowIcon(
              Icons.history,
              offsetX: 0.0,
              offsetY: 0.0,
              blur: 3.0,
              shadowColor: Colors.black.withOpacity(0.25),
            ),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: ShadowIcon(
              Icons.notifications,
              offsetX: 0.0,
              offsetY: 0.0,
              blur: 3.0,
              shadowColor: Colors.black.withOpacity(0.25),
            ),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: ShadowIcon(
              Icons.settings,
              offsetX: 0.0,
              offsetY: 0.0,
              blur: 3.0,
              shadowColor: Colors.black.withOpacity(0.25),
            ),
            label: 'Settings',
          ),
        ],
        backgroundColor: Colors.white,
        iconSize: 28.0,
        activeColor: const Color(0xFF4c9bfb),
        inactiveColor: const Color(0xFFa3a3a3),
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return CupertinoPageScaffold(
              backgroundColor: const Color(0xFFf7f7f7),
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            alignment: AlignmentDirectional.topStart,
                            image: AssetImage(
                                'assets/background/top-background.png'),
                            fit: BoxFit.fitWidth)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: _getBody(index),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
