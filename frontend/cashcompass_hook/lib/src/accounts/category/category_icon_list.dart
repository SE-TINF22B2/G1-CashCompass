import 'package:flutter/cupertino.dart';

enum CategoryIconList {
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
  miscellaneous(CupertinoIcons.circle_grid_3x3_fill, "Miscellaneous");

  const CategoryIconList(this.icon, this.name);

  final IconData icon;
  final String name;
}
