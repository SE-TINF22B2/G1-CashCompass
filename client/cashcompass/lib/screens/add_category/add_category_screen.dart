import 'package:cashcompass_hook/src/accounts/category/category_icons.dart';
import 'package:flutter/cupertino.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({Key? key}) : super(key: key);

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  CategoryIcons selectedIcon = CategoryIcons.values[0];

  _showPicker() async {
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          padding: EdgeInsets.all(8.0),
          color: CupertinoColors.white, // non-transparent background
          child: CupertinoPicker(
            itemExtent: 35,
            onSelectedItemChanged: (index) {
              setState(() {
                selectedIcon = CategoryIcons.values[index];
              });
            },
            children: CategoryIcons.values
                .map((icon) => Row(
                      children: [
                        Icon(icon.icon),
                        SizedBox(
                          width: 10,
                        ),
                        Text(icon.name),
                      ],
                    ))
                .toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("Add Category"),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 25,
                    ),
                    Text("Title"),
                    SizedBox(
                      width: 50,
                    ),
                    Expanded(
                      child: CupertinoTextField(),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 25,
                    ),
                    Text("Icon"),
                    SizedBox(
                      width: 50,
                    ),
                    Expanded(
                      child: CupertinoButton(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(selectedIcon.icon)
                            ]), // aligned to the left
                        onPressed: _showPicker,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: CupertinoButton(
                  color: CupertinoColors.systemGreen,
                  onPressed: handleSaveNewCategory,
                  child: const Text("SAVE"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handleSaveNewCategory() {}
}
