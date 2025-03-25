import 'package:flutter/material.dart';
import 'package:plordle/ui/pages/filter_modal_page.dart';
import 'package:plordle/ui/utils/constants.dart';
import 'package:plordle/ui/utils/enums.dart';
import 'package:plordle/ui/widgets/dialogs/clear_saved_data_dialog.dart';
import 'package:plordle/ui/widgets/dialogs/stats_dialog.dart';
import 'package:plordle/view_models/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

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
          child: ListTile(title: Text("View Stats")),
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) {
                  return StatsDialog();
                });
          },
        ),
        MenuItemButton(
          child: const ListTile(title: Text(Constants.appAndDiffPageTitle)),
          onPressed: () {
            Navigator.pushNamed(context, 'appearanceDifficulty');
          },
        ),
        Consumer<UserViewModel>(builder: (_, model, child) {
          return MenuItemButton(
            child: const ListTile(title: Text(Constants.filterPageTitle)),
            onPressed: () {
              if (model.currentState == GameState.inGame) {
                //Block filter changes while a game is in progress
                ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
                  content: Text(
                      "You cannot change the filter while a game is in progress"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).clearMaterialBanners();
                        },
                        child: const Text("Dismiss"))
                  ],
                ));
              } else if (model.inChallengeMode) {
                ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
                  content: Text(
                      "You cannot use or update the filter while in Challenge Mode"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).clearMaterialBanners();
                        },
                        child: const Text("Dismiss"))
                  ],
                ));
              } else {
                WoltModalSheet.show(
                  context: context,
                  pageListBuilder: (context) {
                    return [FilterModalPage()];
                  },
                  modalTypeBuilder: (context) {
                    final size = MediaQuery.sizeOf(context).width;
                    if (size > Constants.bigScreenCutoffWidth) {
                      return WoltModalType.sideSheet();
                    } else {
                      return WoltModalType.bottomSheet();
                    }
                  },
                  onModalDismissedWithBarrierTap: () {
                    Navigator.of(context).pop();
                  },
                  onModalDismissedWithDrag: () {
                    Navigator.of(context).pop();
                  },
                );
              }
            },
          );
        }),
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
