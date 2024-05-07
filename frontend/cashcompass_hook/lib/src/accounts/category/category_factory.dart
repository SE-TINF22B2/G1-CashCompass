import 'package:cashcompass_hook/src/accounts/category/category.dart';
import 'package:cashcompass_hook/src/accounts/category/category_serializer.dart';
import 'package:cashcompass_hook/src/accounts/category/category_updater.dart';
import 'package:cashcompass_hook/src/accounts/two_step_factory.dart';
import 'package:cashcompass_hook/src/data_storage/database_object.dart';

class CategoryFactory extends Factory<Category, CategorySerializer,
        CategoryFactory, CategoryUpdater>
    with BaseAccountTwoSetDeserialiserFactory, DataclassDeserialiser
    implements TwoStepDesserialisationFactory {
  CategoryFactory(super.accountManager);
  late List<String> soll, haben;
  CategoryFactory create(String name, String color) {
    obj = Category(name, accountManager.nextAccountNumber, color);
    return this;
  }

  @override
  firstStep() {}

  @override
  secondStep() {
    appendTransactions(obj!, soll, haben, accountManager);
  }

  @override
  CategoryFactory deserialise(
      {required Map<String, dynamic> data, bool isRemote = false, String? id}) {
    obj = Category(data["name"], data["account_number"], data["color"]);
    soll = data["soll"];
    haben = data["haben"];
    deserialiseDbObj(id ?? data["id"], !isRemote);
    return this;
  }
}
