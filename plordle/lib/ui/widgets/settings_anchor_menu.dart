import 'package:flutter/material.dart';
import 'package:plordle/ui/utils/constants.dart';
import 'package:plordle/ui/widgets/dialogs/clear_saved_data_dialog.dart';
import 'package:plordle/ui/widgets/filter_chips_widget.dart';
import 'package:plordle/view_models/player_view_model.dart';
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
          child: const ListTile(title: Text(Constants.appAndDiffPageTitle)),
          onPressed: () {
            Navigator.pushNamed(context, 'appearanceDifficulty');
          },
        ),
        MenuItemButton(
          child: const ListTile(title: Text(Constants.filterPageTitle)),
          onPressed: () {
            WoltModalSheet.show(
              context: context,
              pageListBuilder: (context) {
                return [_buildFilterModalPage(context)];
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
          },
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

  SliverWoltModalSheetPage _buildFilterModalPage(BuildContext context) {
    ButtonStyle resetButtonStyle = ElevatedButton.styleFrom(
        backgroundColor: Colors.red, foregroundColor: Colors.white);

    return WoltModalSheetPage(
        topBarTitle: Text(
          Constants.filterPageTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        isTopBarLayerAlwaysVisible: true,
        trailingNavBarWidget: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close)),
        useSafeArea: true,
        stickyActionBar: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  child: ElevatedButton(
                      style: resetButtonStyle,
                      onPressed: () {
                        Provider.of<PlayerViewModel>(context, listen: false)
                            .clearTeamExclusions();
                      },
                      child: const Text("Reset Filter"))),
              SizedBox(
                  child: FilledButton(
                      onPressed: () {
                        Provider.of<PlayerViewModel>(context, listen: false)
                            .storeTeamExclusions();
                        Navigator.of(context).pop();
                      },
                      child: const Text("Submit")))
            ],
          ),
        ),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Text(Constants.filterHelpTextCombined),
              ),
              const SizedBox(height: 8),
              FilterChipsWidget(),
            ]));
  }
}
