import 'package:cashcompass_hook/src/accounts/bookable.dart';
import 'package:cashcompass_hook/src/accounts/two_step_factory.dart';
import 'package:cashcompass_hook/src/data_storage/database_object.dart';
import 'package:cashcompass_hook/src/intervals/interval.dart';
import 'package:cashcompass_hook/src/transactions/recurring_transactions/recurring_transactions.dart';
import 'package:cashcompass_hook/src/transactions/recurring_transactions/recurring_transactions_serializer.dart';
import 'package:cashcompass_hook/src/transactions/recurring_transactions/recurring_transactions_updater.dart';

class RecurringTransactionsFactory extends Factory<
        RecurringTransactions,
        RecurringTransactionsSerializer,
        RecurringTransactionsFactory,
        RecurringTransactionsUpdater>
    with DataclassDeserialiser
    implements TwoStepDesserialisationFactory {
  RecurringTransactionsFactory(super.accountManager);
  late String sollId, habenId;
  String? id;
  late bool isRemote;
  late double amount;
  late DateTime start, end;
  late Interval interval;
  RecurringTransactionsFactory create(
      {required double amount,
      required DateTime startDate,
      required DateTime endDate,
      required Interval interval,
      required Bookable soll,
      required Bookable haben}) {
    obj = RecurringTransactions(
        amount: amount,
        endDate: endDate,
        startDate: startDate,
        haben: haben,
        interval: interval,
        soll: soll);
    return this;
  }

  @override
  RecurringTransactionsFactory deserialise(
      {required Map<String, dynamic> data, bool isRemote = false, String? id}) {
    this.isRemote = isRemote;
    this.id = id;
    sollId = data["soll"].toString();
    habenId = data["haben"].toString();
    amount = double.parse(data["amount"].toString());
    start = DateTime.parse(data["start"]);
    end = DateTime.parse(data["end"]);
    interval = data["interval"];
    return this;
  }

  @override
  RecurringTransactionsFactory firstStep() => this;

  @override
  RecurringTransactionsFactory secondStep() {
    var soll = accountManager.getAccountById(sollId);
    var haben = accountManager.getAccountById(habenId);
    obj = RecurringTransactions(
        amount: amount,
        startDate: start,
        endDate: end,
        interval: interval,
        soll: soll,
        haben: haben);
    deserialiseDbObj(id, !isRemote);
    return this;
  }
}
