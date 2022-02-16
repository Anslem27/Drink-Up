import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import '../../../Models/app_state.dart';
import '../../../Models/water/Drink.dart';
import '../../../actions/history_actions.dart';
import '../../../managers/database/drink_history.dart';

typedef OnDrinkAddedCallback = Function(Drink drink);

//TODO use a dialog input manner.
class DrinkBottomSheet extends StatelessWidget {
  const DrinkBottomSheet({Key key}) : super(key: key);

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
        return GestureDetector(
          onTap: () => showSlidingBottomSheet(
            context,
            builder: (_) => SlidingSheetDialog(
              duration: const Duration(milliseconds: 500),
              cornerRadius: 16,
              snapSpec: const SnapSpec(
                initialSnap: 0.5,
                snappings: [0.5, 0.7],
              ),
              builder: bottomSheet,
            ),
          ),
          child: Image.asset(
            "assets/icons/drinking-water.png",
            height: 55,
            width: 55,
          ),
        );
      },
    );
  }

  Widget bottomSheet(BuildContext context, SheetState state) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 8,
              width: MediaQuery.of(context).size.width / 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.blue[300],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 40,
            ),
            const Text(
              "Pick Your Drink",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 19,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 40,
            ),
            waterRow(),
          ],
        ),
      ),
    );
  }

//? Water Intake categories.....
//200
//300
//500
  waterRow() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Column(
                children: [
                  const Text(
                    "200ml",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      "assets/bottle/glass-of-water.png",
                      height: 55,
                      width: 55,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text(
                    "300ml",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      "assets/bottle/mineral-water.png",
                      height: 55,
                      width: 55,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text(
                    "500ml",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      "assets/bottle/plastic-bottle-blue.png",
                      height: 55,
                      width: 55,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/* 
//? TODO Just Incase  need to reduce code.
class BottomSheetItems {
  String title;
  String subtitle;
  String event;
  String img;
  Function onTap;
  DashBoardItems({this.title, this.subtitle, this.event, this.img, this.onTap});
} */

 /* AnchoredRadialMenu(
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
        );  */