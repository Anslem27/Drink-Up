import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Gender.dart';

typedef DailyGoalChangedCallback = void Function(int dailyGoal);
//typedef void DailyGoalChangedCallback(int dailyGoal);

class DailyGoalCard extends StatefulWidget {
  final int age;
  final Gender gender;
  final int dailyGoal;
  final DailyGoalChangedCallback changed;

  const DailyGoalCard(
      {Key key,
      @required this.age,
      @required this.gender,
      @required this.dailyGoal,
      @required this.changed})
      : super(key: key);

  int suggestedAmount() {
    //int myAge = age != null ? age : 800;
    int myAge = age ?? 800;

    if (myAge < 1) {
      return 800;
    } else if (myAge < 3) {
      return 1300;
    } else if (myAge < 6) {
      return 1700;
    } else if (myAge < 9) {
      return 1900;
    } else if (myAge < 12) {
      int female = 2100;
      int male = 2400;
      if (gender == null) {
        return (female + male) ~/ 2;
      }
      return gender == Gender.male ? male : female;
    } else if (myAge < 15) {
      int female = 2200;
      int male = 3000;
      if (gender == null) {
        return (female + male) ~/ 2;
      }
      return gender == Gender.male ? male : female;
    } else if (myAge < 18) {
      int female = 2300;
      int male = 3300;
      if (gender == null) {
        return (female + male) ~/ 2;
      }
      return gender == Gender.male ? male : female;
    }

    int female = 3000;
    int male = 3500;
    if (gender == null) {
      return (female + male) ~/ 2;
    }

    return gender == Gender.male ? male : female;
  }

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state, prefer_if_null_operators
    return _DailyGoalCardState(dailyGoal != null ? dailyGoal : 0);
  }
}

class _DailyGoalCardState extends State<DailyGoalCard> {
  int _value = 0;

  _DailyGoalCardState(int dailyGoal) {
    _value = dailyGoal;
  }
  dailyGoal() {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          height: MediaQuery.of(context).size.height / 5.8,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            color: Theme.of(context).highlightColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icons/icons8-goal-64.png",
                        height: 40,
                        width: 40,
                      ),
                      Text(
                        "My Goal",
                        style: GoogleFonts.nunitoSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).focusColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 20),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    '$_value ml',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 45.0),
                  child: SizedBox(
                    child: SliderTheme(
                      data: SliderThemeData(
                        trackHeight: 16,
                        thumbColor: Theme.of(context).disabledColor,
                      ),
                      child: Slider(
                        //activeColor: ,
                        onChanged: (double value) {
                          setState(() {
                            _value = value.toInt();
                          });
                        },
                        value: _value.toDouble(),
                        min: 0.0,
                        max: 10000.0,
                        divisions: 20,
                        onChangeEnd: (double value) {
                          widget.changed(value.toInt());
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8, left: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Recommended: ',
                        style: TextStyle(
                          fontSize: 17,
                          color: Theme.of(context).focusColor,
                        ),
                      ),
                      Text(
                        "${widget.suggestedAmount().toString()} ml",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).focusColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return dailyGoal();
  }
}
