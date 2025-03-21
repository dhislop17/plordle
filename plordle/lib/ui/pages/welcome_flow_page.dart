import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:plordle/ui/utils/constants.dart';
import 'package:plordle/ui/widgets/columns/appearance_difficulty_column.dart';
import 'package:plordle/ui/widgets/columns/intro_filter_column.dart';
import 'package:plordle/ui/widgets/columns/intro_text_column.dart';
import 'package:plordle/ui/widgets/page_indicator.dart';
import 'package:plordle/ui/widgets/plordle_layout_builder.dart';
import 'package:plordle/view_models/theme_view_model.dart';
import 'package:provider/provider.dart';

class WelcomeFlowPage extends StatefulWidget {
  const WelcomeFlowPage({super.key});

  @override
  State<WelcomeFlowPage> createState() => _WelcomeFlowPageState();
}

class _WelcomeFlowPageState extends State<WelcomeFlowPage>
    with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;
  int _currPageIndex = 0;

  bool get _isOnDesktop => switch (defaultTargetPlatform) {
        TargetPlatform.macOS ||
        TargetPlatform.linux ||
        TargetPlatform.windows =>
          true,
        TargetPlatform.android ||
        TargetPlatform.iOS ||
        TargetPlatform.fuchsia =>
          false,
      };

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(context),
        body: PlordleLayoutBuilder(
            child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            PageView(
              controller: _pageViewController,
              onPageChanged: _handlePageViewChanged,
              children: <Widget>[
                IntroTextColumn(isOnDesktop: _isOnDesktop),
                AppearanceDifficultyColumn(),
                IntroFilterColumn(
                  isOnDesktop: _isOnDesktop,
                )
              ],
            ),
            PageIndicator(
              tabController: _tabController,
              currentPageIndex: _currPageIndex,
              onUpdateCurrentPageIndex: _updateCurrentPageIndex,
              isOnDesktop: _isOnDesktop,
            ),
          ],
        )));
  }

  AppBar? _buildAppBar(BuildContext context) {
    ThemeViewModel themeViewModel = Provider.of<ThemeViewModel>(context);

    const appBarTitles = [
      Constants.appAndDiffPageTitle,
      Constants.filterPageTitle
    ];
    if (_currPageIndex > 0) {
      return AppBar(
        foregroundColor: themeViewModel.secondarySelectedThemeColor,
        backgroundColor: themeViewModel.primarySelectedThemeColor,
        title: Text(appBarTitles[_currPageIndex - 1]),
        centerTitle: true,
      );
    } else {
      return null;
    }
  }

  void _handlePageViewChanged(int currentPageIndex) {
    setState(() {
      _currPageIndex = currentPageIndex;
    });
    _tabController.index = currentPageIndex;
  }

  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}
