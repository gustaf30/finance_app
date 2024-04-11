import 'package:flutter/material.dart';
import '../core/app_export.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/create_account_screen/create_account_screen.dart';
import '../presentation/homepage_container_screen/homepage_container_screen.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/onboarding_screen/onboarding_screen.dart';
import '../presentation/splash_screen/splash_screen.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class AppRoutes {
  static const String createAccountScreen = '/create_account_screen';

  static const String homepageContainerScreen = '/homepage_container_screen';

  static const String homepagePage = '/homepage_page';

  static const String splashScreen = '/splash_screen';

  static const String onboardingScreen = '/onboarding_screen';

  static const String loginScreen = '/login_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> routes = {
    createAccountScreen: (context) => CreateAccountScreen(),
    homepageContainerScreen: (context) => HomepageContainerScreen(),
    splashScreen: (context) => SplashScreen(),
    onboardingScreen: (context) => OnboardingScreen(),
    loginScreen: (context) => LoginScreen(),
    appNavigationScreen: (context) => AppNavigationScreen(),
    initialRoute: (context) => SplashScreen()
  };
}
