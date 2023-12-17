import 'package:cashcompass_hook/src/transactions/transaction.dart';

abstract class TransactionFactory<IncommingType> {
  Future<Transaction> getTransaction(IncommingType data);
}
