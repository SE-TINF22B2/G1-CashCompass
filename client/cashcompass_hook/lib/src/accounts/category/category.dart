import 'package:cashcompass_hook/src/accounts/bookable.dart';
import 'package:cashcompass_hook/src/accounts/category/category_factory.dart';
import 'package:cashcompass_hook/src/accounts/category/category_serializer.dart';
import 'package:cashcompass_hook/src/accounts/category/category_updater.dart';
import 'package:cashcompass_hook/src/connector/entity_paths.dart';
import 'package:cashcompass_hook/src/currency/currency.dart';

class Category extends RemoteBookable<Category, CategorySerializer,
    CategoryFactory, CategoryUpdater> {
  late String _color;
  late String _icon;
  Category(String name, int accountNumber, String? color, String? icon) {
    _color = color ?? "#000000";
    _icon = icon ?? "";
    this.name = name;
    this.accountNumber = accountNumber;
  }
  @override
  Currency close() {
    return getHabenAmount() - getSollAmount();
  }

  String get colorString => _color;
  String get iconString => _icon;

  @override
  CategorySerializer getSerialiser() {
    return CategorySerializer(this);
  }

  @override
  String getPath() {
    return EntityPaths.category.path;
  }
}
