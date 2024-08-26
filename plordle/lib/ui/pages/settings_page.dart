import 'package:flutter/material.dart';
import 'package:plordle/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App Settings"),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            title: const Text("Change Theme"),
            onTap: () => Navigator.pushNamed(context, 'themeSelect'),
          ),
          ListTile(
            title: const Text("Filter Teams"),
            onTap: () => Navigator.pushNamed(context, 'filter'),
          ),
          ListTile(
            title: const Text("Clear Saved Data"),
            onTap: () => {
              Provider.of<UserViewModel>(context, listen: false)
                  .deleteSavedData()
            },
          )
        ],
      ),
    );
  }
}
