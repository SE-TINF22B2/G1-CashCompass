import 'package:cashcompass_hook/src/connector/specialized_connectors/transaction_connctor.dart';
import 'package:cashcompass_hook/src/dtos/base_dto.dart';

import '../transactions/recurring_transactions.dart';

class RecurringTransactionDTO extends BaseDTO {
  @override
  RecurringTransactions get data => super.data as RecurringTransactions;
  @override
  TransactionConnector get connector => super.connector as TransactionConnector;
  RecurringTransactionDTO(super.id, RecurringTransactions super.data,
      {required super.connector});
  Future<double> changeAmount(double newAmount) {
    return connector.changeRecurringTransactionAmount(data, newAmount);
    
  }
}
