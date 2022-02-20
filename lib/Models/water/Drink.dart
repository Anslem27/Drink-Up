abstract class Drink {
  final String name;
  final int amount;

  Drink(this.name, this.amount);

  // TODO:Create Additional variables where neccesary
  //TODO: Add momre drink options,plus custom ones for the users.

  //? Water Drinks

  factory Drink.small() => Water(200);
  factory Drink.medium() => Water(300);
  factory Drink.big() => Water(500);

  //? Juice Drinks
//TODO: must be abt 300(pet bottle),500(medium bottle),850(big bottle)
  /* factory Drink.smallJuice() => Water(200);
  factory Drink.mediumJuice() => Water(300);
  factory Drink.bigJuice() => Water(500); */

  factory Drink.fromAmount(int amount) {
    switch (amount) {
      case 200:
        return Drink.small();
      case 300:
        return Drink.medium();
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
