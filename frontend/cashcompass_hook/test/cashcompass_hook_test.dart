import 'package:cashcompass_hook/src/accounts/active_account/active_account.dart';
import 'package:cashcompass_hook/src/accounts/active_account/active_account_factory.dart';
import 'package:cashcompass_hook/src/accounts/category/category.dart';
import 'package:cashcompass_hook/src/accounts/category/category_factory.dart';
import 'package:cashcompass_hook/src/accounts/passive_account/passive_account.dart';
import 'package:cashcompass_hook/src/accounts/passive_account/passive_account_factory.dart';
import 'package:cashcompass_hook/src/data_storage/accoutmanager.dart';
import 'package:cashcompass_hook/src/transactions/recurring_transactions/recurring_transactions_factory.dart';
import 'package:cashcompass_hook/src/transactions/transactions/transactions_factory.dart';
import 'package:cron/cron.dart';
import 'package:test/test.dart';

import 'helper.dart';

void main() {
  group("Hook startup", () {
    test('Init mock connector', () {});

    test('Init Account Vault', () {
      Accountmanager();
    });
  });

  group("Serialiser", () {
    Accountmanager manager = Accountmanager();
    test('Active Account', () {
      var acc = ActiveAccountFactory(manager).create("test1").build();
      var map = acc.getSerialiser().toJson();
      assert(TestHelper.checkFields(
          ["id", "isUploaded", "soll", "haben", "name", "account_number"],
          map));
    });
    test('Passive Account', () {
      var acc = PassiveAccountFactory(manager).create("test1").build();
      var map = acc.getSerialiser().toJson();
      assert(TestHelper.checkFields(
          ["id", "isUploaded", "soll", "haben", "name", "account_number"],
          map));
      assert(map.keys.length == 6);
    });

    test('Category Account', () {
      var acc = CategoryFactory(manager).create("test", "#666666").build();
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
      var acc = CategoryFactory(manager).create("test1", "#666666").build();
      var acc2 = CategoryFactory(manager).create("test2", "#666666").build();
      var tr = TransactionsFactory(manager)
          .create(amount: 566.0, soll: acc, haben: acc2)
          .build();
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
      var acc = CategoryFactory(manager).create("test1", "#666666").build();
      var acc2 = CategoryFactory(manager).create("test2", "#666666").build();
      var tr = RecurringTransactionsFactory(manager)
          .create(
              amount: 566.0,
              startDate: DateTime.now(),
              endDate: DateTime.now(),
              interval: Schedule(minutes: 5).toCronString(),
              soll: acc,
              haben: acc2)
          .build();
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
  group("Factories", () {
    Accountmanager manager = Accountmanager();
    test("Active Account Create", () {
      var fac = ActiveAccountFactory(manager);
      ActiveAcount f = fac.create("TestAccount").build();
      expect(f.name, "TestAccount");
    });

    test("Passive Account Create", () {
      var fac = PassiveAccountFactory(manager);
      PassiveAccount f = fac.create("TestAccount").build();
      expect(f.name, "TestAccount");
    });

    test("Category Create", () {
      var fac = CategoryFactory(manager);
      Category f = fac.create("Yeet", "#666666").build();
      expect(f.name, "Yeet");
    });

    test("Transaction Create", () {
      var fac = TransactionsFactory(manager);
      var soll = PassiveAccount("test1", 1);
      var haben = PassiveAccount("test2", 2);
      var f = fac.create(amount: 566.0, soll: soll, haben: haben).build();
      expect(f.amount, 566.0);
    });

    test("Recurring Transaction Create", () {
      var fac = RecurringTransactionsFactory(manager);
      var soll = PassiveAccount("test1", 1);
      var haben = PassiveAccount("test2", 2);
      var f = fac
          .create(
              amount: 566.0,
              startDate: DateTime.now(),
              endDate: DateTime.now(),
              interval: Schedule(minutes: 5).toCronString(),
              soll: soll,
              haben: haben)
          .build();
      expect(f.amount, 566.0);
    });
  });

  group("Serialise and Deserialise", () {
    Accountmanager manager = Accountmanager();
    test("Active Account", () {
      var fac = ActiveAccountFactory(manager);
      ActiveAcount f = fac.create("TestAccount").build();
      var data = f.getSerialiser().toJson();
      var acc = ActiveAccountFactory(manager).deserialise(data: data).build();
      expect(f.id, acc.id);
      expect(f.accountNumber, acc.accountNumber);
      expect(f.name, acc.name);
    });

    test("Passive Account", () {
      var fac = PassiveAccountFactory(manager);
      var f = fac.create("TestAccount").build();
      var data = f.getSerialiser().toJson();
      var acc = PassiveAccountFactory(manager).deserialise(data: data).build();
      expect(f.id, acc.id);
      expect(f.accountNumber, acc.accountNumber);
      expect(f.name, acc.name);
    });
    test("Category Account", () {
      var fac = CategoryFactory(manager);
      var f = fac.create("TestAccount", "#666666").build();
      var data = f.getSerialiser().toJson();
      var acc = CategoryFactory(manager).deserialise(data: data).build();
      expect(f.id, acc.id);
      expect(f.accountNumber, acc.accountNumber);
      expect(f.name, acc.name);
      expect(f.colorString, acc.colorString);
    });

    test("Missing id", () {
      var fac = CategoryFactory(manager);
      var f = fac.create("TestAccount", "#666666").build();
      var data = f.getSerialiser().toJson();
      data.removeWhere((key, value) => key == "id");
      expect(() => CategoryFactory(manager).deserialise(data: data).build(),
          throwsA(const TypeMatcher<Exception>()));
    });
  });
}
