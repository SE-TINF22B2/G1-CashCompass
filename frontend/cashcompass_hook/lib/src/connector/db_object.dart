class DbObject {
  String? _id;
  String get id => _id!;
  bool get isUploaded => _id != null;
  DbObject({String? id}) {
    _id = id;
  }
}
