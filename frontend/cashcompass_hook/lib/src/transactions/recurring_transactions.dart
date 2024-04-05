import 'package:cashcompass_hook/src/accounts/account.dart';
import 'package:cashcompass_hook/src/accounts/bookable.dart';
import 'package:cashcompass_hook/src/connector/connector.dart';
import 'package:cashcompass_hook/src/currency/currency.dart';
import 'package:cashcompass_hook/src/dtos/data_class.dart';
import 'package:cashcompass_hook/src/dtos/recurring_transaction_dto.dart';

class RecurringTransactions extends DataClass<RecurringTransactionDTO> {
  late double _amount;
  late DateTime _startDate, _endDate;
  late Duration _interval;
  late Bookable _sollAccount;
  late Bookable _habenAccount;

  Currency get amount => _amount;
  DateTime get startDate => _startDate;
  DateTime get endDate => _endDate;
  Bookable get soll => _sollAccount;
  Bookable get haben => _habenAccount;
  Duration get interval => _interval;
  RecurringTransactions(
      {required super.dto,
      required amount,
      required DateTime startDate,
      required DateTime endDate,
      required Duration interval,
      required Bookable soll,
      required Bookable haben}) {
    _amount = amount;
    _startDate = startDate;
    _endDate = endDate;
    _sollAccount = soll;
    _habenAccount = haben;
  }

  @override
  Future<RecurringTransactionDTO> getDTO(Connector connector) {
    throw UnimplementedError();
  }
}
