import 'package:cashcompass_hook/src/accounts/account.dart';
import 'package:cashcompass_hook/src/connector/connector.dart';
import 'package:cashcompass_hook/src/dtos/data_class.dart';
import 'package:cashcompass_hook/src/dtos/recurring_transaction_dto.dart';

class RecurringTransactions extends DataClass<RecurringTransactionDTO> {
  late double _amount;
  late DateTime _startDate, _endDate;
  late Duration _interval;
  late Account _activeAccount;
  late Account _passiveAccount;

  double get amount => _amount;
  DateTime get startDate => _startDate;
  DateTime get endDate => _endDate;
  Account get active => _activeAccount;
  Account get passve => _passiveAccount;
  Duration get interval => _interval;
  RecurringTransactions(
      {required super.dto,
      required amount,
      required DateTime startDate,
      required DateTime endDate,
      required Duration interval,
      required Account active,
      required Account passive}) {
    _amount = amount;
    _startDate = startDate;
    _endDate = endDate;
    _activeAccount = active;
    _passiveAccount = passive;
  }

  @override
  Future<RecurringTransactionDTO> getDTO(Connector connector) {
    throw UnimplementedError();
  }
}
