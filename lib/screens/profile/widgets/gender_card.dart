import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Gender.dart';

typedef GenderChangedCallback = void Function(Gender gender);

class GenderSelectorCard extends StatefulWidget {
  final GenderChangedCallback changed;
  final Gender value;

  const GenderSelectorCard(
      {Key key, @required this.value, @required this.changed})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return _GenderSelectorCardState(value);
  }
}

class _GenderSelectorCardState extends State<GenderSelectorCard> {
  Gender _selectedGender;

  _GenderSelectorCardState(this._selectedGender);

  void selectGender(Gender gender) {
    widget.changed(gender);

    setState(() {
      _selectedGender = gender;
    });
  }

  genderCard() {
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
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Gender",
                      style: GoogleFonts.nunitoSans(fontSize: 22),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            selectGender(Gender.male);
                          },
                          icon: Icon(
                            Icons.male,
                            color: _selectedGender == Gender.male
                                ? Colors.blue[800]
                                : Colors.grey,
                            size: 40,
                          ),
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          onPressed: () {
                            selectGender(Gender.female);
                          },
                          icon: Icon(
                            Icons.female,
                            color: _selectedGender == Gender.female
                                ?  Colors.pink
                                : Colors.grey,
                            size: 40,
                          ),
                        ),
                      ],
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

  @override
  Widget build(BuildContext context) {
    return genderCard();
  }
}
