import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/chats_screen/chats_screen.dart';
import 'package:flutter_application_1/presentation/check_in_screen/check_in_screen.dart';
import 'package:flutter_application_1/presentation/dashboard_after_check_in/dashboard_after_check_in_screen.dart';
import 'package:flutter_application_1/presentation/dashboard_before_check_in_container_screen/dashboard_before_check_in_container_screen.dart';
import 'package:flutter_application_1/presentation/dashboard_before_check_in_screen/dashboard_before_check_in_screen.dart';
import 'package:flutter_application_1/presentation/login_screen/login_screen.dart';
import 'package:flutter_application_1/presentation/register_screen/register_screen.dart';
import 'package:flutter_application_1/presentation/splash_screen/splash_screen.dart';
import 'package:flutter_application_1/presentation/way_finder_screen/way_finder_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';

  static const String loginWithEmailIdScreen = '/login_with_email_id_screen';

  static const String registerScreen = '/register_screen';

  static const String dashboardBeforeCheckInScreen =
      '/dashboard_before_check_in_screen';

  static const String dahsboardBeforeCheckInPage =
      '/dahsboard_before_check_in_page';

  static const String dahsboardBeforeCheckInContainerScreen =
      '/dahsboard_before_check_in_container_screen';

  static const String dashboardAfterCheckInScreen =
      '/dashboard_after_check_in_screen';

  static const String chatsScreenOneScreen = '/chats_screen_one_screen';

  static const String chatsScreen = '/chats_screen';

  static const String chatsScreenTwoScreen = '/chats_screen_two_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String initialRoute = '/initialRoute';

  static const String checkInScreen = '/check_in_screen';

  static const String wayFinderScreen = '/way_finder_screen';

  static Map<String, WidgetBuilder> get routes => {
        splashScreen: SplashScreen.builder,
        loginWithEmailIdScreen: LoginWithEmailIdScreen.builder,
        registerScreen: RegisterScreen.builder,
        dashboardBeforeCheckInScreen: DashboardBeforeCheckInScreen.builder,
        dahsboardBeforeCheckInContainerScreen:
            DahsboardBeforeCheckInContainerScreen.builder,
        dashboardAfterCheckInScreen: DashboardAfterCheckInScreen.builder,
        checkInScreen: CheckInScreen.builder,
        chatsScreen: ChatsScreen.builder,
        wayFinderScreen: WayFinderScreen.builder,

        // chatsScreenOneScreen: ChatsScreenOneScreen.builder,
        // chatsScreenTwoScreen: ChatsScreenTwoScreen.builder,
        // appNavigationScreen: AppNavigationScreen.builder,
        initialRoute: SplashScreen.builder
      };
}
