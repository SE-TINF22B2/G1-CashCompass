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
  late String sollId, habenId;
  String? id;
  late bool isRemote;
  late int transactionNr;
  late double amount;
  TransactionsFactory create(
      {required double amount,
      required Bookable soll,
      required Bookable haben}) {
    obj = Transaction(
        transactionNumber: accountManager.nextTransactionNumber,
        soll: soll,
        haben: haben,
        amount: amount);
    return this;
  }

  @override
  deserialise(
      {required Map<String, dynamic> data, bool isRemote = false, String? id}) {
    sollId = data["sollId"];
    habenId = data["habenId"];
    amount = data["amount"];
    transactionNr = data["transactionNr"];
    this.id = id;
    isRemote = isRemote;
  }

  @override
  firstStep() {}

  @override
  secondStep() {
    var soll = accountManager.getAccountById(sollId);
    var haben = accountManager.getAccountById(habenId);
    obj = Transaction(
        transactionNumber: transactionNr,
        soll: soll,
        haben: haben,
        amount: amount);
    deserialiseDbObj(id, !isRemote);
  }
}
