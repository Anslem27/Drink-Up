import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Models/app_state.dart';
import '../../../Models/water/Drink.dart';
import '../../../actions/glass_actions.dart';
import '../../../actions/history_actions.dart';
import '../../../managers/database/drink_history.dart';
import '../../../widgets/Reusable Widgets/shadow_text.dart';
import '../history_manager.dart';
import '../history_page.dart';

class HistoryLists extends StatefulWidget {
  final TabController tabController;

  const HistoryLists({Key key, this.tabController}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HistoryListsState();
  }
}

class _HistoryListsState extends State<HistoryLists> {
  List<Widget> lists = [];

  void _buildListsWithEntries() {
    for (int i = 0; i < 4; i++) {
      Widget list = StoreConnector<AppState, List<DrinkHistoryEntry>>(
          converter: (store) => store.state.drinksHistory,
          builder: (context, entries) {
            List<DrinkHistoryEntry> currentEntries =
                HistoryManager.manager.currentEntries(entries, i);

            if (currentEntries.isEmpty) {
              //? When a user hasnt drunk anyting yet.
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height / 40),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        //TODO make the images somewhat random dynamic.
                        child: Image.asset(
                          "assets/illustrations/conifer-milkshake.png",
                          height: 240,
                          width: 240,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 40),
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "You hav'nt had anything to drink today...",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunitoSans(fontSize: 19),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Center(
              child: ListView.builder(
                key: Key("history_$i"),
                itemCount: currentEntries.length,
                itemBuilder: (BuildContext context, int index) {
                  var entry = currentEntries[index];

                  return StoreConnector<AppState, OnDrinkEntryRemovedCallback>(
                    converter: (store) {
                      return (entry) {
                        store.dispatch(RemoveDrinkFromHistoryAction(entry));
                        var drink = Drink.fromAmount(entry.amount);
                        store.dispatch(RemoveDrinkAction(drink));
                      };
                    },
                    builder: (context, callback) {
                      return Dismissible(
                        child: Container(
                          height: MediaQuery.of(context).size.height / 7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, bottom: 8.0),
                          child: DrinkHitoryListItem(
                            entry.amount,
                            DateTime.fromMillisecondsSinceEpoch(entry.date),
                          ),
                        ),
                        key: entry.id != null
                            ? Key(entry.id.toString())
                            : UniqueKey(),
                        background: Container(
                          height: MediaQuery.of(context).size.height / 10,
                          decoration: BoxDecoration(
                            color: Colors.red[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Align(
                            alignment: Alignment.center,
                            child: ShadowText(
                              'Swipe to remove',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,),
                            ),
                          ),
                        ),
                        onDismissed: (direction) {
                          currentEntries.removeAt(index);
                          setState(() {
                            callback(entry);
                          });
                        },
                      );
                    },
                  );
                },
              ),
            );
          });

      lists.add(list);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (lists.isEmpty) {
      _buildListsWithEntries();
    }

    return TabBarView(
      controller: widget.tabController,
      physics: const NeverScrollableScrollPhysics(),
      children: lists,
    );
  }
}