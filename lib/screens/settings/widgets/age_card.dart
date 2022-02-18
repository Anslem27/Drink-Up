import 'package:flutter/material.dart';

typedef AgeChangedCallback = void Function(int age);

class AgeSelectorCard extends StatefulWidget {
  final AgeChangedCallback changed;
  final int value;

  const AgeSelectorCard({Key key, @required this.value, @required this.changed})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // ignore: prefer_if_null_operators, no_logic_in_create_state
    return _AgeSelectorCardState(value != null ? value : 0);
  }
}

class _AgeSelectorCardState extends State<AgeSelectorCard> {
  int _value = 0;

  _AgeSelectorCardState(this._value);

  ageSelectCard() {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            Container(
              height: 110,
              width: MediaQuery.of(context).size.width / 2.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.orange[100],
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Age\n $_value",
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).focusColor,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Slider(
                        onChanged: (double value) {
                          setState(() {
                            _value = value.round();
                          });
                        },
                        value: _value.toDouble(),
                        min: 0.0,
                        max: 100.0,
                        divisions: 100,
                        onChangeEnd: (double value) {
                          widget.changed(value.round());
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ageSelectCard();
  }
}
