enum EntityPaths {
  activeaccount("active_account"),
  passiveaccount("passive_account"),
  category("category"),
  transaction("transaction"),
  recurringtransations("recurring_transactions");

  const EntityPaths(this.path);
  final String path;

  @override
  toString() {
    return path;
  }
}
