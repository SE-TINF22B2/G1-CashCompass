import 'package:cashcompass_hook/src/accounts/bookable.dart';
import 'package:cashcompass_hook/src/accounts/two_step_factory.dart';
import 'package:cashcompass_hook/src/data_storage/database_object.dart';
import 'package:cashcompass_hook/src/transactions/transactions/transaction.dart';
import 'package:cashcompass_hook/src/transactions/transactions/transaction_updater.dart';
import 'package:cashcompass_hook/src/transactions/transactions/transactions_serializer.dart';

class TransactionsFactory extends Factory<Transaction, TransactionsSerializer,
        TransactionsFactory, TransactionsUpdater>
    with DataclassDeserialiser
    implements TwoStepDesserialisationFactory {
  TransactionsFactory(super.accountManager);
  late int sollNr, habenNr;
  String? id;
  late bool isRemote;
  late int transactionNr;
  late double amount;
  late String label;
  TransactionsFactory create(
      {required double amount,
      required Bookable soll,
      required Bookable haben,
      required String label}) {
    obj = Transaction(
        transactionNumber: accountManager.nextTransactionNumber,
        soll: soll,
        haben: haben,
        amount: amount,
        label: label);
    return this;
  }

  @override
  TransactionsFactory deserialise(
      {required Map<String, dynamic> data, bool isRemote = false, String? id}) {
    sollNr = data["soll"] ?? 0;
    habenNr = data["haben"] ?? 0;
    amount = 1.0 * data["amount"];
    label = data["label"];
    transactionNr = data["transactionNumber"];
    this.id = id ?? data["ID"];
    this.isRemote = isRemote;
    return this;
  }

  @override
  TransactionsFactory firstStep() => this;

  @override
  TransactionsFactory secondStep() {
    var soll = accountManager.getAccount(sollNr)!;
    var haben = accountManager.getAccount(habenNr)!;
    obj = Transaction(
        transactionNumber: transactionNr,
        soll: soll,
        haben: haben,
        amount: amount,
        label: label);
    soll.appendTransaction(obj!);
    haben.appendTransaction(obj!);
    deserialiseDbObj(id, !isRemote);
    return this;
  }
}
