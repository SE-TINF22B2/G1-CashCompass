import 'package:cashcompass_hook/src/accounts/category/category.dart';
import 'package:cashcompass_hook/src/accounts/category/category_serializer.dart';
import 'package:cashcompass_hook/src/accounts/category/category_updater.dart';
import 'package:cashcompass_hook/src/data_storage/database_object.dart';

class CategoryFactory extends Factory<Category> {
  CategoryFactory(super.connector);

  @override
  DatabaseObject<Category, CategorySerializer, CategoryFactory, CategoryUpdater>
      build() {
    // TODO: implement build
    throw UnimplementedError();
  }
}
