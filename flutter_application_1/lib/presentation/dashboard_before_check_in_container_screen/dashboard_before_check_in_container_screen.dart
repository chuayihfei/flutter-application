import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/chats_screen/chats_screen.dart';
import 'package:flutter_application_1/presentation/dashboard_before_check_in_container_screen/provider/dashboard_before_check_in_container_provider.dart';
import 'package:flutter_application_1/presentation/dashboard_before_check_in_screen/dashboard_before_check_in_screen.dart';
import 'package:flutter_application_1/widgets/custom_bottom_app_bar.dart';
import 'package:flutter_application_1/widgets/custom_floating_button.dart';

import '../../core/app_export.dart';

class DahsboardBeforeCheckInContainerScreen extends StatefulWidget {
  const DahsboardBeforeCheckInContainerScreen({Key? key}) : super(key: key);

  @override
  DahsboardBeforeCheckInContainerScreenState createState() =>
      DahsboardBeforeCheckInContainerScreenState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => DahsboardBeforeCheckInContainerProvider(),
        child: const DahsboardBeforeCheckInContainerScreen());
  }
}

// ignore_for_file: must_be_immutable
class DahsboardBeforeCheckInContainerScreenState
    extends State<DahsboardBeforeCheckInContainerScreen> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Navigator(
                key: navigatorKey,
                initialRoute: AppRoutes.dahsboardBeforeCheckInPage,
                onGenerateRoute: (routeSetting) => PageRouteBuilder(
                    pageBuilder: (ctx, ani, ani1) =>
                        getCurrentPage(context, routeSetting.name!),
                    transitionDuration: Duration(seconds: 0))),
            bottomNavigationBar: _buildButtomNavBar(context),
            floatingActionButton: CustomFloatingButton(
                height: 65,
                width: 63,
                backgroundColor: theme.colorScheme.primary,
                child: CustomImageView(
                    imagePath: ImageConstant.imgPlus,
                    height: 32.5.v,
                    width: 31.5.h)),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked));
  }

  /// Section Widget
  Widget _buildButtomNavBar(BuildContext context) {
    return CustomBottomAppBar(onChanged: (BottomBarEnum type) {
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
  }

  ///Handling route based on bottom click actions
  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Dashboard:
        return AppRoutes.dahsboardBeforeCheckInPage;
      case BottomBarEnum.Chats:
        return AppRoutes.chatsScreen;
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(
    BuildContext context,
    String currentRoute,
  ) {
    switch (currentRoute) {
      case AppRoutes.dashboardBeforeCheckInScreen:
        return DashboardBeforeCheckInScreen.builder(context);
      case AppRoutes.chatsScreen:
        return ChatsScreen.builder(context);
      default:
        return const DefaultWidget();
    }
  }
}
