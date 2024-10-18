import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moviequotes/managers/auth_manager.dart';

class ListPageDrawer extends StatelessWidget {
  final void Function() showOnlyMineCallback;
  final void Function() showAllCallback;

  const ListPageDrawer({
    required this.showOnlyMineCallback,
    required this.showAllCallback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            child: const Text(
              "Movie Quotes",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 28.0,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Show only my quotes"),
            onTap: () {
              Navigator.of(context).pop();
              showOnlyMineCallback();
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text("Show all quotes"),
            onTap: () {
              Navigator.of(context).pop();
              showAllCallback();
            },
          ),
          const Spacer(),
          const Divider(
            thickness: 2.0,
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {
              Navigator.of(context).pop();
              AuthManager.instance.signOut();
            },
          )
        ],
      ),
    );
  }
}
