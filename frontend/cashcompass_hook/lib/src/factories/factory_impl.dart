import 'package:cashcompass_hook/src/factories/account_factory.dart';
import 'package:cashcompass_hook/src/factories/transaction_factory.dart';

abstract class Factory
    implements TransactionFactory<String>, AccountFactory<String, String> {}
