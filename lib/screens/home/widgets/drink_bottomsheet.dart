import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import '../../../Models/app_state.dart';
import '../../../Models/water/Drink.dart';
import '../../../Settings/Widgets/reusable_widgets.dart';
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
                snappings: [0.5, 0.8],
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
                fontSize: 22,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 55),
            waterSheet(context, callback),
            SizedBox(height: MediaQuery.of(context).size.height / 40),
            const Text(
              "Juices",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 22,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 40),
            juiceSheet(context, callback),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Colors.blue[800],
                ),
                //SizedBox(width: 3),
                const Text(
                  "More",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                  ),
                ),
                //SizedBox(width: 3),
                Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Colors.blue[800],
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 40),
            sodasAndMore(context, callback),
          ],
        ),
      ),
    );
  }

  juiceSheet(BuildContext context, OnDrinkAddedCallback callback) {
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
                    "250ml",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      callback(Drink.smallJuice());
                      Navigator.pop(context);
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
                      callback(Drink.mediumJuice());
                      Navigator.pop(context);
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
                      callback(Drink.bigJuice());
                      Navigator.pop(context);
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

  waterSheet(BuildContext context, OnDrinkAddedCallback callback) {
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
                    "250ml",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      callback(Drink.small());
                      Navigator.pop(context);
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
                      callback(Drink.medium());
                      Navigator.pop(context);
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
                      callback(Drink.big());
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      "assets/bottle/plastic-bottle-blue.png",
                      height: 60,
                      width: 65,
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

  sodasAndMore(BuildContext context, OnDrinkAddedCallback callback) {
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => showDialog(
                      context: context,
                      builder: (_) => QuirkyDialog(
                        assetImage: "assets/bottle/soda.png",
                        title: "Soda's",
                        child: sodaDialogBody(callback, context),
                      ),
                    ),
                    child: Image.asset(
                      "assets/bottle/soda.png",
                      height: 55,
                      width: 55,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Cola/Soda's",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => showDialog(
                      context: context,
                      builder: (_) => QuirkyDialog(
                        assetImage: "assets/icons/big-milk.png",
                        title: 'Diary',
                        child: diaryDialogBody(callback, context),
                      ),
                    ),
                    child: Image.asset(
                      "assets/bottle/milkshake.png",
                      height: 55,
                      width: 55,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Dairy Drinks",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => showDialog(
                      context: context,
                      builder: (_) => QuirkyDialog(
                        assetImage: "assets/bottle/coconut.png",
                        title: 'Uncategorized Drinks',
                        child: uncategorizedDialogBody(callback, context),
                      ),
                    ),
                    child: Image.asset(
                      "assets/bottle/coconut.png",
                      height: 55,
                      width: 55,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Uncategorized" /* "500ml" */,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
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

  sodaDialogBody(OnDrinkAddedCallback callback, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
                    "250ml",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      /* callback(Drink.small());
                      Navigator.pop(context);*/
                    },
                    child: Image.asset(
                      "assets/icons/can.png",
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
                      /* callback(Drink.medium());
                      Navigator.pop(context);*/
                    },
                    child: Image.asset(
                      "assets/icons/coke.png",
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
                      /* callback(Drink.big());
                    Navigator.pop(context); */
                    },
                    child: Image.asset(
                      "assets/icons/soft-drink.png",
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

  diaryDialogBody(OnDrinkAddedCallback callback, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
                    "250ml",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      /* callback(Drink.small());
                      Navigator.pop(context);*/
                    },
                    child: Image.asset(
                      "assets/bottle/milkshake.png",
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
                      /* callback(Drink.medium());
                      Navigator.pop(context);*/
                    },
                    child: Image.asset(
                      "assets/icons/milk.png",
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
                      /* callback(Drink.big());
                    Navigator.pop(context); */
                    },
                    child: Image.asset(
                      "assets/icons/big-milk.png",
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

  uncategorizedDialogBody(OnDrinkAddedCallback callback, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
                    "250ml",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      
                    },
                    child: Image.asset(
                      "assets/icons/wine.png",
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
                      /* callback(Drink.medium());
                      Navigator.pop(context);*/
                    },
                    child: Image.asset(
                      "assets/icons/water-bottle.png",
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
                      /* callback(Drink.big());
                    Navigator.pop(context); */
                    },
                    child: Image.asset(
                      "assets/icons/water-big.png",
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


