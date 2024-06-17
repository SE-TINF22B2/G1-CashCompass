import 'dart:developer';

import 'package:cashcompass_hook/src/accounts/active_account/active_account.dart';
import 'package:cashcompass_hook/src/accounts/active_account/active_account_factory.dart';
import 'package:cashcompass_hook/src/accounts/active_account/active_account_serializer.dart';
import 'package:cashcompass_hook/src/accounts/active_account/active_account_updater.dart';
import 'package:cashcompass_hook/src/accounts/category/category.dart';
import 'package:cashcompass_hook/src/accounts/category/category_factory.dart';
import 'package:cashcompass_hook/src/accounts/initial_pull.dart';
import 'package:cashcompass_hook/src/accounts/passive_account/passive_account.dart';
import 'package:cashcompass_hook/src/accounts/passive_account/passive_account_factory.dart';
import 'package:cashcompass_hook/src/chart_of_accounts.dart/chart_of_accounts.dart';
import 'package:cashcompass_hook/src/connector/entity_paths.dart';
import 'package:cashcompass_hook/src/connector/mock_classes/mock_data_adapter.dart';
import 'package:cashcompass_hook/src/connector/remote_storage.dart';
import 'package:cashcompass_hook/src/connector/rest_client.dart';
import 'package:cashcompass_hook/src/data_storage/accout_manager.dart';
import 'package:cashcompass_hook/src/transactions/recurring_transactions/recurring_transactions_factory.dart';
import 'package:cashcompass_hook/src/transactions/transactions/transactions_factory.dart';
import 'package:cron/cron.dart';
import 'package:test/test.dart';

import 'helper.dart';

void main() {
  group("Chart of Accounts", () {
    Accountmanager accManager = Accountmanager(dataAdapter: MockDataAdapter());
    late ChartOfAccounts chart;
    setUp(() async {
      await accManager.init();
      chart = ChartOfAccounts(accManager);
    });

    test("Get All Categories", () {
      expect(chart.getCategories().isNotEmpty, true);
      expect(chart.getCategories(matcher: (p0) => false).isEmpty, true);
    });
  });

  group("Hook startup", () {
    Accountmanager accManager = Accountmanager(dataAdapter: MockDataAdapter());
    setUp(() async {
      await accManager.init();
    });
    test('Init mock dataadapter', () {
      MockDataAdapter();
    });

    test('Init Account Vault', () async {
      await Accountmanager(dataAdapter: MockDataAdapter()).init();
    });

    test('insert Sth', () async {
      var acc = (await accManager.readStorage<
              ActiveAccountFactory,
              ActiveAccount,
              ActiveAccountSerializer,
              ActiveAccountUpdater>(EntityPaths.activeaccount, "11"))
          .firstStep()
          .secondStep()
          .build();
      try {
        var t = await accManager.readStorage<ActiveAccountFactory,
                ActiveAccount, ActiveAccountSerializer, ActiveAccountUpdater>(
            EntityPaths.activeaccount, "1efjaefnaefjanefanefane");
        expect(t, false); // statement must fail
        // ignore: empty_catches
      } catch (e) {
        log("Exception was expected!");
      }
      await accManager.writeStorage(acc);
    });
  });

  group("Serialiser", () {
    Accountmanager manager = Accountmanager(dataAdapter: MockDataAdapter());
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
      var acc = CategoryFactory(manager)
          .create("test", "#666666", "StopSign")
          .build();
      var map = acc.getSerialiser().toJson();
      assert(TestHelper.checkFields([
        "id",
        "isUploaded",
        "soll",
        "haben",
        "name",
        "account_number",
        "color",
        "icon"
      ], map));
      assert(map.keys.length == 8);
    });

    test('Transaction', () {
      var acc = CategoryFactory(manager)
          .create("test1", "#666666", "StopSign")
          .build();
      var acc2 = CategoryFactory(manager)
          .create("test2", "#666666", "StopSign")
          .build();
      var tr = TransactionsFactory(manager)
          .create(
              amount: 566.0, soll: acc, haben: acc2, label: "Test Transaction")
          .build();
      var map = tr.getSerialiser().toJson();
      assert(TestHelper.checkFields([
        "id",
        "isUploaded",
        "soll",
        "haben",
        "amount",
        "timestamp",
        "transactionNumber",
        "label"
      ], map));
      assert(map.keys.length == 8);
    });
    test('Recurring Transaction', () {
      var acc = CategoryFactory(manager)
          .create("test1", "#666666", "StopSign")
          .build();
      var acc2 = CategoryFactory(manager)
          .create("test2", "#666666", "StopSign")
          .build();
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
    Accountmanager manager = Accountmanager(dataAdapter: MockDataAdapter());
    test("Active Account Create", () {
      var fac = ActiveAccountFactory(manager);
      ActiveAccount f = fac.create("TestAccount").build();
      expect(f.name, "TestAccount");
    });

    test("Passive Account Create", () {
      var fac = PassiveAccountFactory(manager);
      PassiveAccount f = fac.create("TestAccount").build();
      expect(f.name, "TestAccount");
    });

    test("Category Create", () {
      var fac = CategoryFactory(manager);
      Category f = fac.create("Yeet", "#666666", "StopSign").build();
      expect(f.name, "Yeet");
    });

    test("Transaction Create", () {
      var fac = TransactionsFactory(manager);
      var soll = PassiveAccount("test1", 1);
      var haben = PassiveAccount("test2", 2);
      var f = fac
          .create(
              amount: 566.0,
              soll: soll,
              haben: haben,
              label: "Test Transaction")
          .build();
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
    Accountmanager manager = Accountmanager(dataAdapter: MockDataAdapter());
    test("Active Account", () {
      var fac = ActiveAccountFactory(manager);
      ActiveAccount f = fac.create("TestAccount").build();
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
      var f = fac.create("TestAccount", "#666666", "StopSign").build();
      var data = f.getSerialiser().toJson();
      var acc = CategoryFactory(manager).deserialise(data: data).build();
      expect(f.id, acc.id);
      expect(f.accountNumber, acc.accountNumber);
      expect(f.name, acc.name);
      expect(f.colorString, acc.colorString);
      expect(f.iconString, acc.iconString);
    });

    test("Missing id", () {
      var fac = CategoryFactory(manager);
      var f = fac.create("TestAccount", "#666666", "StopSign").build();
      var data = f.getSerialiser().toJson();
      data.removeWhere((key, value) => key == "id");
      expect(() => CategoryFactory(manager).deserialise(data: data).build(),
          throwsA(const TypeMatcher<Exception>()));
    });
  });

  group("RemoteStorage", () {
    RestClient restClient = RestClient(
        baseUrl:
            "https://9c632b52trial-dev-backend-cap-srv.cfapps.us10-001.hana.ondemand.com/odata/v4");

    Accountmanager accManager =
        Accountmanager(dataAdapter: RemoteStorage(restClient));
    late ChartOfAccounts chart;
    setUp(() async {
      await accManager.init();
      chart = ChartOfAccounts(accManager);
    });

    test("Get All Categories", () {
      print(chart.getCategories());
      // expect(chart.getCategories().isNotEmpty, true);
      // expect(chart.getCategories(matcher: (p0) => false).isEmpty, true);
    });
  });
}
