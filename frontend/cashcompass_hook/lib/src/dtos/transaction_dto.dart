import 'package:cashcompass_hook/src/connector/specialized_connectors/transaction_connctor.dart';
import 'package:cashcompass_hook/src/dtos/base_dto.dart';
import 'package:cashcompass_hook/src/transactions/transaction.dart';

class TransactionDTO extends BaseDTO {
  @override
  Transaction get data => super.data as Transaction;
  TransactionDTO(super.id, Transaction super.data, {required TransactionConnector super.connector});
}
