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
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Text(
                        "@simiquatsch",
                        style: TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          const CupertinoTextField(
                            placeholder: "Friendcode !! Coming Soon !!",
                            enabled: false,
                          ),
                          const SizedBox(height: 8),
                          CupertinoTextField(
                            controller: _emailController,
                            placeholder: "Email",
                            readOnly: true,
                          ),
                          const SizedBox(height: 8),
                          CupertinoTextField(
                            placeholder: "Recurring Transactions",
                            readOnly: true,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: CupertinoColors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: CupertinoColors.lightBackgroundGray,
                              ),
                            ),
                            child: Column(
                              children: [
                                _buildListTile(
                                  amount: "300.00€",
                                  description: "Miete",
                                  color: CupertinoColors.systemRed,
                                  icon: CupertinoIcons.minus,
                                ),
                                _buildDivider(),
                                _buildListTile(
                                  amount: "75.00€",
                                  description: "DAZN",
                                  color: CupertinoColors.systemRed,
                                  icon: CupertinoIcons.minus,
                                ),
                                _buildDivider(),
                                _buildListTile(
                                  amount: "20.00€",
                                  description: "Kindergeld",
                                  color: CupertinoColors.systemGreen,
                                  icon: CupertinoIcons.plus,
                                ),
                              ],
                            ),
                          ),
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
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({
    required String amount,
    required String description,
    required Color color,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: CupertinoListTile(
        title: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                amount,
                textAlign: TextAlign.right,
                style: TextStyle(color: color),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 4,
              child: Text(description),
            ),
          ],
        ),
        onTap: handleRecurringTransactionDetails,
        leading: Icon(
          icon,
          color: CupertinoColors.black,
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: CupertinoColors.lightBackgroundGray,
      thickness: 1,
      indent: 0,
      endIndent: 0,
      height: 1,
    );
  }

  void handleLogout() {
    // Handle logout functionality
  }

  void handleEditModeChange() {
    // Handle edit mode change functionality
  }

  void handleRecurringTransactionDetails() {
    // Handle recurring transaction details functionality
  }
}
