// ignore_for_file: file_names
class Drink {
  final String name;
  final int amount;

  Drink(this.name, this.amount);

  //TODO: Add more drink options,plus custom ones for the users.

  //? Water Drinks

  factory Drink.small() => Water(250);
  factory Drink.medium() => Water(300);
  factory Drink.big() => Water(500);

  //? Juice Drinks
//TODO: must be abt 300(pet bottle),500(medium bottle),850(big bottle)
  factory Drink.smallJuice() => Water(251);
  factory Drink.mediumJuice() => Water(301);
  factory Drink.bigJuice() => Water(501);

  factory Drink.fromAmount(int? amount) {
    switch (amount) {
      case 250:
        return Drink.small();
      case 300:
        return Drink.medium();
      case 251:
        return Drink.small();
      case 301:
        return Drink.medium();
      case 501:
        return Drink.big();
      case 500:
        return Drink.medium();
      default:
        return Drink.big();
    }
  }
}

class Water extends Drink {
  Water(int amount) : super('Water', amount);
}
