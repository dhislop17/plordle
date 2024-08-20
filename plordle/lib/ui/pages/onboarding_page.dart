import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:plordle/ui/utils/text_constants.dart';
import 'package:plordle/ui/widgets/theme_selection_list.dart';
import 'package:plordle/view_models/theme_view_model.dart';
import 'package:plordle/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Logger logger = Logger(printer: PrettyPrinter());
  static const List<Tab> tabs = [
    Tab(text: "Choose Theme"),
    Tab(text: "Filter Teams")
  ];
  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(updateIndex);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void updateIndex() {
    setState(() {
      tabIndex = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(TextConstants.onboardingPageTitle),
        centerTitle: true,
        bottom: TabBar(tabs: tabs, controller: _tabController),
      ),
      body: TabBarView(controller: _tabController, children: [
        const ThemeSelectionList(),
        Container(
          color: Provider.of<ThemeViewModel>(context).primarySelectedThemeColor,
        )
      ]),
      floatingActionButton: (tabIndex == 1)
          ? FloatingActionButton.extended(
              label: const Text("Continue"),
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                //save theme selection and mark onboarding complete
                Provider.of<ThemeViewModel>(context, listen: false).saveData();
                Provider.of<UserViewModel>(context, listen: false)
                    .completeOnboarding();

                Navigator.pushReplacementNamed(context, 'game');
              },
            )
          : null,
    );
  }
}
