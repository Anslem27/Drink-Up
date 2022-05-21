import 'package:flutter/material.dart';

typedef AgeChangedCallback = void Function(int age);

class AgeSelectorCard extends StatefulWidget {
  final AgeChangedCallback changed;
  final int? value;

  const AgeSelectorCard({Key? key, required this.value, required this.changed})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // ignore: prefer_if_null_operators, no_logic_in_create_state
    return _AgeSelectorCardState(value != null ? value : 0);
  }
}

class _AgeSelectorCardState extends State<AgeSelectorCard> {
  int? _value = 0;

  _AgeSelectorCardState(this._value);

  ageSelectCard() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Stack(
        children: [
          Container(
            height: 110,
            width: MediaQuery.of(context).size.width / 2.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).highlightColor,
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "My Age\n $_value",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            color: Theme.of(context).focusColor,
                          ),
                        ),
                        Image.asset(
                          ageGetter(),
                          height: 32,
                          width: 32,
                        ),
                      ],
                    ),
                  ),
                ),
                //TODO: Proly return a text editable popup dialog
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: SliderTheme(
                      data: SliderThemeData(
                        thumbColor: Theme.of(context).disabledColor,
                      ),
                      child: Slider(
                        onChanged: (double value) {
                          setState(() {
                            _value = value.round();
                          });
                        },
                        value: _value!.toDouble(),
                        min: 0.0,
                        max: 100.0,
                        divisions: 100,
                        onChangeEnd: (double value) {
                          widget.changed(value.round());
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String ageGetter() {
    if (_value! > 0 && _value! < 10) {
      return "assets/icons/baby-boy.png";
    } else if (_value! >= 10 && _value! < 29) {
      return "assets/icons/teenager.png";
    } else if (_value! >= 29 && _value! < 35) {
      return "assets/icons/beard.png";
    } else {
      return "assets/icons/man.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return ageSelectCard();
  }
}
