import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:plordle/ui/utils/constants.dart';
import 'package:plordle/ui/widgets/columns/appearance_difficulty_column.dart';
import 'package:plordle/ui/widgets/columns/intro_filter_column.dart';
import 'package:plordle/ui/widgets/columns/intro_text_column.dart';
import 'package:plordle/ui/widgets/page_indicator.dart';
import 'package:plordle/ui/widgets/plordle_layout_builder.dart';
import 'package:plordle/view_models/player_view_model.dart';
import 'package:plordle/view_models/theme_view_model.dart';
import 'package:plordle/view_models/user_view_model.dart';
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
    var userModel = Provider.of<UserViewModel>(context, listen: false);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: PlordleLayoutBuilder(child: _buildPageView(context)),
      floatingActionButton: (!_isOnDesktop &&
              _currPageIndex == 2) // Only show FAB if on the third page
          ? FloatingActionButton.extended(
              label: const Text(Constants.startButtonLabel),
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                _completeWelcomeFlow(userModel);
              },
            )
          : null,
    );
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

  Widget _buildPageView(BuildContext context) {
    return Stack(
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
                completeWelcomeFlow: _completeWelcomeFlow)
          ],
        ),
        PageIndicator(
          tabController: _tabController,
          currentPageIndex: _currPageIndex,
          onUpdateCurrentPageIndex: _updateCurrentPageIndex,
          isOnDesktop: _isOnDesktop,
        ),
      ],
    );
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

  void _completeWelcomeFlow(UserViewModel userModel) {
    //save theme selection, team exclusions, difficulty level, and mark onboarding complete
    Provider.of<ThemeViewModel>(context, listen: false).saveData();
    Provider.of<PlayerViewModel>(context, listen: false).storeTeamExclusions();
    userModel.saveDifficulty();
    userModel.completeOnboarding();

    Navigator.pushReplacementNamed(context, 'game');
  }
}
