import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../Models/app_state.dart';
import '../../../Models/water/Drink.dart';
import '../../../actions/history_actions.dart';
import '../../../managers/database/drink_history.dart';
import '../../../widgets/circle_menu/circle_menu.dart';

typedef OnDrinkAddedCallback = Function(Drink drink);
//TODO use a dialog input manner.
class DrinkMenu extends StatelessWidget {
  const DrinkMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, OnDrinkAddedCallback>(
      converter: (store) {
        return (drink) {
          var entry = DrinkHistoryEntry();
          entry.amount = drink.amount;
          entry.date = DateTime.now().millisecondsSinceEpoch;
          store.dispatch(AddDrinkToHistoryAction(entry));
        };
      },
      builder: (context, callback) {
        return AnchoredRadialMenu(
          menu: Menu(items: [
            RadialMenuItem(
                text: '200',
                onPressed: () {
                  callback(Drink.small());
                }),
            RadialMenuItem(
                text: '250',
                onPressed: () {
                  callback(Drink.medium());
                }),
            RadialMenuItem(
                text: '300',
                onPressed: () {
                  callback(Drink.big());
                }),
          ]),
          child: IconButton(
            icon: const Icon(
              Icons.cancel,
            ),
            onPressed: () {},
          ),
        );
      },
    );
  }
}
