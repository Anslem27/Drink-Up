import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../../actions/glass_actions.dart';
import '../../../actions/history_actions.dart';
import '../../../managers/database/drink_history.dart';
import '../../../model/app_state.dart';
import '../../../model/water/Drink.dart';
import '../../../widgets/Reusable Widgets/shadow_text.dart';
import '../../../widgets/container_wrapper/container_wrapper.dart';
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
              // Empty list
              return const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: ContainerWrapper(
                    widthScale: 1.0,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'You have not drunk anything yet! To add a drink go to the Today page and use the menu with drinks.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xFF363535),
                            fontWeight: FontWeight.w300),
                      ),
                    ),
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
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, bottom: 8.0),
                          child: ContainerWrapper(
                            widthScale: 1.0,
                            child: DrinkHitoryListItem(
                              entry.amount,
                              DateTime.fromMillisecondsSinceEpoch(entry.date),
                            ),
                          ),
                        ),
                        key: entry.id != null
                            ? Key(entry.id.toString())
                            : UniqueKey(),
                        background: Container(
                          color: Colors.red.withAlpha(30),
                          child: const Align(
                            alignment: Alignment.center,
                            child: ShadowText(
                              'Swipe to remove',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
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
