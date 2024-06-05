import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _emailController;
  @override
  void initState() {
    // TODO: implement initState
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: const Text("Hi Simon!"),
          trailing: IconButton(
            onPressed: handleEditModeChange,
            icon: const Icon(CupertinoIcons.pencil),
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text(
                    "Simon E.",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const CupertinoTextField(
                        placeholder: "friendcode",
                        enabled: false,
                      ),
                      CupertinoTextField(
                        controller: _emailController,
                        placeholder: "email",
                        readOnly: true,
                      ),
                      CupertinoTextField(
                        placeholder: "recurring Transactions",
                        readOnly: true,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CupertinoListSection(
                          children: [
                            CupertinoListTile(
                              title: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "300.00€",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          color: CupertinoColors.systemRed),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Text("Miete"),
                                  ),
                                ],
                              ),
                              onTap: handleRecurringTransactionDetails,
                              leading: const Icon(
                                CupertinoIcons.minus,
                                color: CupertinoColors.black,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: CupertinoButton(
                    child: const Text("LOGOUT"),
                    onPressed: handleLogout,
                    color: CupertinoColors.systemRed,
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void handleLogout() {}

  void handleEditModeChange() {}

  void handleRecurringTransactionDetails() {}
}
