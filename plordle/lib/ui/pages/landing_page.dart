import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:plordle/services/service_locator.dart';
import 'package:plordle/services/storage_service.dart';
import 'package:plordle/ui/pages/home_page.dart';
import 'package:plordle/ui/pages/welcome_flow_page.dart';

class LandingPage extends StatelessWidget {
  final Logger logger = Logger(printer: PrettyPrinter());
  final StorageService _storageService = serviceLocator<StorageService>();

  LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    logger.d("Building Landing Page");
    return FutureBuilder(
      future: _storageService.getOnboardingStatus(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          bool onboarded = snapshot.data!;
          if (onboarded) {
            logger.d("Onboarding Complete, loading Main Game Page");
            return const HomePage();
          } else {
            logger.d("Onboarding Incomplete, loading Onboarding Page");
            return const WelcomeFlowPage();
          }
        } else {
          logger.d("No Snapshot Data, loading Onboarding Page");
          return const WelcomeFlowPage();
        }
      },
    );
  }
}
