import 'package:flutter/material.dart';
import 'package:plordle/ui/widgets/dialogs/clear_saved_data_dialog.dart';

class SettingsAnchorMenu extends StatefulWidget {
  const SettingsAnchorMenu({super.key});

  @override
  State<SettingsAnchorMenu> createState() => _SettingsAnchorMenuState();
}

class _SettingsAnchorMenuState extends State<SettingsAnchorMenu> {
  final FocusNode _buttonFocusNode = FocusNode();

  @override
  void dispose() {
    _buttonFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      childFocusNode: _buttonFocusNode,
      menuChildren: <Widget>[
        MenuItemButton(
          child: const ListTile(title: Text("Appearance & Difficulty")),
          onPressed: () {
            Navigator.pushNamed(context, 'appearanceDifficulty');
          },
        ),
        MenuItemButton(
          child: const ListTile(title: Text("Filter Teams")),
          onPressed: () => Navigator.pushNamed(context, 'filter'),
        ),
        MenuItemButton(
          child: const ListTile(
            title: Text("Reset Game Stats"),
          ),
          onPressed: () {
            var banner = MaterialBanner(
              content: const Text("Cleared game stats"),
              actions: [
                TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).clearMaterialBanners();
                    },
                    child: const Text("Dismiss"))
              ],
            );
            ScaffoldMessenger.of(context).showMaterialBanner(banner);
          },
        ),
        MenuItemButton(
          child: const ListTile(
            title: Text("Clear All Saved Data"),
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return const ClearSavedDataDialog();
                });
          },
        ),
      ],
      builder: (_, MenuController controller, Widget? child) {
        return IconButton(
            onPressed: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                controller.open();
              }
            },
            icon: const Icon(Icons.settings));
      },
    );
  }
}
