import 'package:cashcompass_hook/src/accounts/bookable.dart';
import 'package:cashcompass_hook/src/accounts/category/category_factory.dart';
import 'package:cashcompass_hook/src/accounts/category/category_serializer.dart';
import 'package:cashcompass_hook/src/accounts/category/category_updater.dart';
import 'package:cashcompass_hook/src/connector/entity_paths.dart';
import 'package:cashcompass_hook/src/currency/currency.dart';

class Category extends RemoteBookable<Category, CategorySerializer,
    CategoryFactory, CategoryUpdater> {
  late String _color;
  Category(String name, int accountNumber, String color) {
    _color = color;
    this.name = name;
    this.accountNumber = accountNumber;
  }
  @override
  Currency close() {
    return getHabenAmount() - getSollAmount();
  }

  String get colorString => _color;

  @override
  CategorySerializer getSerialiser() {
    return CategorySerializer(this);
  }

  @override
  String getPath() {
    return EntityPaths.category.path;
  }
}
