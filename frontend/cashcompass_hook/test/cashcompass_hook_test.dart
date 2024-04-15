import 'package:cashcompass_hook/src/accounts/active_account/active_account.dart';
import 'package:cashcompass_hook/src/accounts/active_account/active_account_factory.dart';
import 'package:cashcompass_hook/src/accounts/category/category.dart';
import 'package:cashcompass_hook/src/accounts/passive_account/passive_account.dart';
import 'package:cashcompass_hook/src/data_storage/accoutmanager.dart';
import 'package:cashcompass_hook/src/transactions/recurring_transactions/recurring_transactions.dart';
import 'package:cashcompass_hook/src/transactions/transactions/transaction.dart';
import 'package:test/test.dart';

import 'helper.dart';

void main() {
  group("Hook startup", () {
    test('Init mock connector', () {});

    test('Init Account Vault', () {
      Accountmanager();
    });
  });

  group("Serialiser / Factories", () {
    test('Active Account', () {
      var acc = ActiveAcount("Test", 1);
      var map = acc.getSerialiser().toJson();
      assert(TestHelper.checkFields(
          ["id", "isUploaded", "soll", "haben", "name", "account_number"],
          map));
    });
    test('Passive Account', () {
      var acc = PassiveAccount("Test", 1);
      var map = acc.getSerialiser().toJson();
      assert(TestHelper.checkFields(
          ["id", "isUploaded", "soll", "haben", "name", "account_number"],
          map));
      assert(map.keys.length == 6);
    });

    test('Category Account', () {
      var acc = Category("Test", 1, "#666666");
      var map = acc.getSerialiser().toJson();
      assert(TestHelper.checkFields([
        "id",
        "isUploaded",
        "soll",
        "haben",
        "name",
        "account_number",
        "color"
      ], map));
      assert(map.keys.length == 7);
    });

    test('Transaction', () {
      var acc = Category("Test", 1, "#666666");
      var acc2 = Category("Test", 1, "#666666");
      var tr = Transaction(
        amount: 166,
        haben: acc2,
        soll: acc,
        transactionNumber: 56,
        timestamp: DateTime.now(),
      );
      var map = tr.getSerialiser().toJson();
      assert(TestHelper.checkFields([
        "id",
        "isUploaded",
        "soll",
        "haben",
        "amount",
        "timestamp",
        "transactionNumber"
      ], map));
      assert(map.keys.length == 7);
    });
    test('Recurring Transaction', () {
      var acc = Category("Test", 1, "#666666");
      var acc2 = Category("Test", 1, "#666666");
      var tr = RecurringTransactions(
        amount: 166.0,
        haben: acc2,
        soll: acc,
        endDate: DateTime.now(),
        startDate: DateTime.now(),
        interval: const Duration(hours: 1),
      );
      var map = tr.getSerialiser().toJson();
      assert(TestHelper.checkFields([
        "id",
        "isUploaded",
        "soll",
        "haben",
        "amount",
        "start",
        "end",
        "interval"
      ], map));
      assert(map.keys.length == 8);
    });
  });
}
