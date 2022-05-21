import 'package:redux/redux.dart';

import '../Models/water/Glass.dart';
import '../actions/intake_actions.dart';

final glassReducers = combineReducers<Glass?>([
  TypedReducer<Glass?, AddDrinkAction>(_addDrink),
  TypedReducer<Glass?, RemoveDrinkAction>(_removeDrink),
]);

Glass _addDrink(Glass? glass, AddDrinkAction action) {
  return glass!.addDrink(action.drink);
}

Glass _removeDrink(Glass? glass, RemoveDrinkAction action) {
  return glass!.removeDrink(action.drink);
}
