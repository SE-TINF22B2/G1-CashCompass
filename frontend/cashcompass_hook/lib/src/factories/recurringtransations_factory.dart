import 'package:cashcompass_hook/src/transactions/recurring_transactions.dart';

abstract class RecurringTransactionFactory<IncommingType> {
  Future<RecurringTransactions> createRecurringTransaction(IncommingType data);
}
