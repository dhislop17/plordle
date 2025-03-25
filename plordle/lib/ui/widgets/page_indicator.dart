import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.tabController,
    required this.currentPageIndex,
    required this.onUpdateCurrentPageIndex,
    required this.isOnDesktop,
  });

  final int currentPageIndex;
  final TabController tabController;
  final void Function(int) onUpdateCurrentPageIndex;
  final bool isOnDesktop;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IgnorePointer(
          ignoring: (currentPageIndex == 0 || !isOnDesktop) ? true : false,
          child: Visibility.maintain(
            visible: (currentPageIndex == 0 || !isOnDesktop) ? false : true,
            child: IconButton(
              splashRadius: 16.0,
              padding: EdgeInsets.zero,
              onPressed: () {
                onUpdateCurrentPageIndex(currentPageIndex - 1);
              },
              icon: const Icon(Icons.arrow_left_rounded, size: 32.0),
            ),
          ),
        ),
        TabPageSelector(
          controller: tabController,
          color: colorScheme.surface,
          selectedColor: colorScheme.primary,
        ),
        IgnorePointer(
          ignoring: (currentPageIndex == 2 || !isOnDesktop) ? true : false,
          child: Visibility.maintain(
            visible: (currentPageIndex == 2 || !isOnDesktop) ? false : true,
            child: IconButton(
              splashRadius: 16.0,
              padding: EdgeInsets.zero,
              onPressed: () {
                onUpdateCurrentPageIndex(currentPageIndex + 1);
              },
              icon: const Icon(Icons.arrow_right_rounded, size: 32.0),
            ),
          ),
        ),
      ],
    );
  }
}
