import 'package:cashcompass_hook/src/connector/specialized_connectors/transaction_connctor.dart';
import 'package:cashcompass_hook/src/dtos/base_dto.dart';
import 'package:cashcompass_hook/src/transactions/transaction.dart';

class TransactionDTO extends BaseDTO {
  @override
  Transaction get data => super.data as Transaction;
  @override
  TransactionConnector get connector => super.connector as TransactionConnector;
  TransactionDTO(super.id, Transaction super.data,
      {required TransactionConnector super.connector});

  @override
  Future<String> upload() async {
    var ret = await connector.createTransaction(
        soll: data.soll,
        haben: data.haben,
        amount: data.amount,
        timestamp: data.timestamp,
        transactionNumber: data.transactionNumber);
    return ret.dto.id;
  }
}
