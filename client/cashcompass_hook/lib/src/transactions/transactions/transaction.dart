import 'package:cashcompass_hook/src/accounts/bookable.dart';
import 'package:cashcompass_hook/src/connector/entity_paths.dart';
import 'package:cashcompass_hook/src/currency/currency.dart';
import 'package:cashcompass_hook/src/data_storage/database_object.dart';
import 'package:cashcompass_hook/src/transactions/transactions/transaction_updater.dart';
import 'package:cashcompass_hook/src/transactions/transactions/transactions_factory.dart';
import 'package:cashcompass_hook/src/transactions/transactions/transactions_serializer.dart';

class Transaction
    with
        DatabaseObject<Transaction, TransactionsSerializer, TransactionsFactory,
            TransactionsUpdater> {
  final Bookable soll;
  final Bookable haben;
  final Currency amount;
  // TODO create transactionnumber if there is non overgiven
  late final int _transacionNumber;
  late final DateTime timestamp;
  final String label;
  int get transactionNumber => _transacionNumber;
  Transaction(
      {required int transactionNumber,
      required this.soll,
      required this.haben,
      required this.amount,
      DateTime? timestamp,
      required this.label}) {
    if (timestamp == null) {
      this.timestamp = DateTime.now();
    } else {
      this.timestamp = timestamp;
    }
    _transacionNumber = transactionNumber;
  }
  @override
  String toString() {
    return "Transaction: $_transacionNumber | $amount $soll to $haben";
  }

  @override
  TransactionsSerializer getSerialiser() {
    return TransactionsSerializer(this);
  }

  @override
  String getPath() {
    return EntityPaths.transaction.path;
  }
}
