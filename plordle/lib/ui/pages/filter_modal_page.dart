import 'package:flutter/material.dart';
import 'package:plordle/ui/utils/constants.dart';
import 'package:plordle/ui/widgets/filter_chips_widget.dart';
import 'package:plordle/view_models/player_view_model.dart';
import 'package:provider/provider.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class FilterModalPage extends WoltModalSheetPage {
  FilterModalPage()
      : super(
            topBarTitle: Builder(builder: (context) {
              return Text(
                Constants.filterPageTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              );
            }),
            isTopBarLayerAlwaysVisible: true,
            trailingNavBarWidget: Builder(builder: (context) {
              return IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close));
            }),
            useSafeArea: true,
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 8, right: 8),
                      child: Text(Constants.filterHelpTextFirstLine)),
                  SizedBox(height: 8),
                  Padding(
                      padding: EdgeInsets.only(left: 8, right: 8),
                      child: Text(Constants.filterHelpTextSecondLine)),
                  const SizedBox(height: 8),
                  FilterChipsWidget(),
                  const SizedBox(height: 80),
                ]),
            stickyActionBar: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Builder(builder: (context) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                        child: OutlinedButton.icon(
                            icon: Icon(Icons.restart_alt_outlined),
                            onPressed: () {
                              Provider.of<PlayerViewModel>(context,
                                      listen: false)
                                  .clearTeamExclusions();
                            },
                            label: const Text("Reset Filter"))),
                    SizedBox(
                        child: FilledButton(
                            onPressed: () {
                              Provider.of<PlayerViewModel>(context,
                                      listen: false)
                                  .storeTeamExclusions();
                              Navigator.of(context).pop();
                            },
                            child: const Text("Done")))
                  ],
                );
              }),
            ));
}
