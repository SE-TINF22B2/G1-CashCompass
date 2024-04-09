import 'package:cashcompass_hook/src/accounts/category/category.dart';
import 'package:cashcompass_hook/src/data_storage/database_object.dart';

abstract class CategoryUpdater extends Updater<Category> {
  CategoryUpdater(super.connector);
}
