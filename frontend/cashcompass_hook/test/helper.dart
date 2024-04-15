class TestHelper {
  static bool checkFields(List<String> field, Map<String, dynamic> map) {
    for (var element in field) {
      if (!map.containsKey(element)) {
        return false;
      }
    }
    return true;
  }
}
