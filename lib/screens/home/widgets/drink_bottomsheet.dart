import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import '../../../Models/app_state.dart';
import '../../../Models/water/Drink.dart';
import '../../../actions/history_actions.dart';
import '../../../managers/database/drink_history.dart';

typedef OnDrinkAddedCallback = Function(Drink drink);

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
              builder: (_, SheetState state) {
                return drinkBottomSheet(context, callback);
              },
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

  drinkBottomSheet(BuildContext context, OnDrinkAddedCallback callback) {
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
            SizedBox(height: MediaQuery.of(context).size.height / 40),
            const Text(
              "Pick Your Drink",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 19,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 55),
            waterSheet(context, callback),
            SizedBox(height: MediaQuery.of(context).size.height / 40),
            const Text(
              "Juices",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 40),
            juiceSheet(context, callback),
          ],
        ),
      ),
    );
  }

  Padding juiceSheet(BuildContext context, OnDrinkAddedCallback callback) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  //? Small Juice Intake
                  const Text(
                    "200ml",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop;
                      callback(Drink.small());
                    },
                    child: Image.asset(
                      "assets/icons/juice-box.png",
                      height: 55,
                      width: 55,
                    ),
                  ),
                ],
              ),
              //? Medium Juice intake
              Column(
                children: [
                  const Text(
                    "300ml",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop;
                      callback(Drink.medium());
                    },
                    child: Image.asset(
                      "assets/bottle/medium-juice.png",
                      height: 55,
                      width: 55,
                    ),
                  ),
                ],
              ),
              //? High Juice intake
              Column(
                children: [
                  const Text(
                    "500ml",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop;
                      callback(Drink.big());
                    },
                    child: Image.asset(
                      "assets/bottle/big-juice.png",
                      height: 60,
                      width: 60,
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

  Padding waterSheet(BuildContext context, OnDrinkAddedCallback callback) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //? Small Water intake
              Column(
                children: [
                  const Text(
                    "200ml",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop;
                      callback(Drink.small());
                    },
                    child: Image.asset(
                      "assets/bottle/glass-of-water.png",
                      height: 55,
                      width: 50,
                    ),
                  ),
                ],
              ),
              //? Medium Water intake
              Column(
                children: [
                  const Text(
                    "300ml",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop;
                      callback(Drink.medium());
                    },
                    child: Image.asset(
                      "assets/bottle/mineral-water.png",
                      height: 55,
                      width: 55,
                    ),
                  ),
                ],
              ),
              //? High Water intake.
              Column(
                children: [
                  const Text(
                    "500ml",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop;
                      callback(Drink.big());
                    },
                    child: Image.asset(
                      "assets/bottle/plastic-bottle-blue.png",
                      height: 60,
                      width: 60,
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
//? Water Intake categories.....
//200
//300
//500

//! TODO Add more options ie  [cola,soda(even no sugar),uncategorized]
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
