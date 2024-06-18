enum EntityPaths {
  activeaccount("ActiveAccounts"),
  passiveaccount("PassiveAccounts"),
  category("Categories"),
  transaction("Transactions"),
  recurringtransations("RecurrintTransactions");

  const EntityPaths(this.path);
  final String path;

  @override
  toString() {
    return path;
  }
}
