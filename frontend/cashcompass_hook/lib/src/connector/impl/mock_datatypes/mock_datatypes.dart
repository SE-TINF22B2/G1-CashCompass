class MockAccount {
  String id;
  String name;
  int accountNumber;
  MockAccount(
      {required this.id, required this.name, required this.accountNumber});
}

class MockCategory extends MockAccount {
  String color;
  MockCategory(
      {required this.color,
      required super.id,
      required super.name,
      required super.accountNumber});
}

class MockRecurringTransactions {
  String id;
  String sollId;
  String habenId;
  double amount;
  Duration intervall;
  DateTime start, end;
  MockRecurringTransactions(
      {required this.id,
      required this.sollId,
      required this.habenId,
      required this.amount,
      required this.end,
      required this.intervall,
      required this.start});
}

class MockTransaction {
  String id;
  String sollId;
  String habenId;
  double amount;
  DateTime timestamp;
  int transactionNumer;
  MockTransaction(
      {required this.transactionNumer,
      required this.id,
      required this.amount,
      required this.habenId,
      required this.sollId,
      required this.timestamp});
}
