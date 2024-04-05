import 'package:cashcompass_hook/src/accounts/bookable.dart';
import 'package:cashcompass_hook/src/connector/specialized_connectors/transaction_connctor.dart';
import 'package:cashcompass_hook/src/dtos/base_dto.dart';
import 'package:cashcompass_hook/src/dtos/data_class.dart';

class Transaction extends DataClass {
  final Bookable soll;
  final Bookable haben;
  final double amount;
  // TODO create transactionnumber if there is non overgiven
  late final int _transacionNumber;
  late final DateTime timestamp;
  int get transactionNumber => _transacionNumber;
  Transaction(
      {required super.dto,
      required int transactionNumber,
      required this.soll,
      required this.haben,
      required this.amount,
      DateTime? timestamp}) {
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
  Future<BaseDTO> getDTO(TransactionConnector connector) {
    throw UnimplementedError();
  }
}
