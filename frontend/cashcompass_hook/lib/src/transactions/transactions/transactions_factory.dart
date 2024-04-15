import 'package:cashcompass_hook/src/accounts/bookable.dart';
import 'package:cashcompass_hook/src/data_storage/database_object.dart';
import 'package:cashcompass_hook/src/transactions/transactions/transaction.dart';
import 'package:cashcompass_hook/src/transactions/transactions/transaction_updater.dart';
import 'package:cashcompass_hook/src/transactions/transactions/transactions_serializer.dart';

class TransactionsFactory extends Factory<Transaction, TransactionsSerializer,
    TransactionsFactory, TransactionsUpdater> {
  TransactionsFactory(super.accountManager);

  create(
      {required double amount,
      required Bookable soll,
      required Bookable haben}) {
    obj = Transaction(
        transactionNumber: accountManager.nextTransactionNumber,
        soll: soll,
        haben: haben,
        amount: amount);
  }
}
