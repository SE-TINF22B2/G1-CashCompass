import 'package:flutter/cupertino.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Add Category"),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
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
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 25,
                    ),
                    Text("Icon"),
                    SizedBox(
                      width: 58,
                    ),
                    Expanded(
                      child: CupertinoTextField(),
                    )
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
