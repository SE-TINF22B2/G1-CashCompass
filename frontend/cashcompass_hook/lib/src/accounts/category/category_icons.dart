import 'package:flutter/cupertino.dart';

enum CategoryIcons {
  groceries(CupertinoIcons.cart, "Groceries"),
  diningOut(CupertinoIcons.heart, "Dining Out"),
  transport(CupertinoIcons.car, "Transport"),
  fuel(CupertinoIcons.drop, "Fuel"),
  utilities(CupertinoIcons.bolt, "Utilities"),
  rentMortgage(CupertinoIcons.house, "Rent/Mortgage"),
  entertainment(CupertinoIcons.music_note, "Entertainment"),
  healthFitness(CupertinoIcons.heart_circle, "Health & Fitness"),
  insurance(CupertinoIcons.shield, "Insurance"),
  education(CupertinoIcons.book, "Education"),
  travel(CupertinoIcons.airplane, "Travel"),
  shopping(CupertinoIcons.bag, "Shopping"),
  personalCare(CupertinoIcons.person, "Personal Care"),
  subscriptions(CupertinoIcons.money_dollar, "Subscriptions"),
  savings(CupertinoIcons.money_dollar, "Savings"),
  giftsDonations(CupertinoIcons.gift, "Gifts & Donations"),
  taxes(CupertinoIcons.money_euro, "Taxes"),
  loans(CupertinoIcons.creditcard, "Loans"),
  homeMaintenance(CupertinoIcons.house_alt, "Home Maintenance"),
  pets(CupertinoIcons.paw, "Pets"),
  miscellaneous(CupertinoIcons.circle_grid_3x3_fill, "Miscellaneous"),
  stopSign(CupertinoIcons.hand_raised, "Stop Sign");

  const CategoryIcons(this.icon, this.name);

  final IconData icon;
  final String name;

  static CategoryIcons fromName(String name) {
    return CategoryIcons.values.firstWhere(
        (categoryIcon) => categoryIcon.name == name,
        orElse: () => CategoryIcons.stopSign);
  }
}
