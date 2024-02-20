import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/app_export.dart';
import 'package:flutter_application_1/presentation/dashboard_before_check_in_container_screen/dashboard_before_check_in_container_screen.dart';
import 'package:flutter_application_1/services/firebase_auth_service.dart';
import 'package:flutter_application_1/services/firebase_firestore_service.dart';
import 'package:flutter_application_1/widgets/app_bar/appbar_leading_image.dart';
import 'package:flutter_application_1/widgets/app_bar/appbar_title.dart';
import 'package:flutter_application_1/widgets/app_bar/appbar_trailing_image.dart';
import 'package:flutter_application_1/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter_application_1/widgets/custom_bottom_app_bar.dart';
import 'package:flutter_application_1/widgets/custom_floating_button.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'provider/check_in_provider.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({Key? key})
      : super(
          key: key,
        );

  @override
  CheckInScreenState createState() => CheckInScreenState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CheckInProvider(),
      child: const CheckInScreen(),
    );
  }
}

class CheckInScreenState extends State<CheckInScreen> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  UnityWidgetController? _unityWidgetController;

  void onUnityCreated(controller) async {
    _unityWidgetController = controller;

    const permission = Permission.camera;

    if (await permission.isDenied) {
      await permission.request();
    }
  }

  void onUnitySceneLoaded(SceneLoaded? sceneInfo) {
    if (sceneInfo != null) {
      log('Received scene loaded from unity: ${sceneInfo.name}');
      log('Received scene loaded from unity buildIndex: ${sceneInfo.buildIndex}');
    }
  }

  void onUnityMessage(message) async {
    _unityWidgetController?.postMessage('AR Session Origin', 'ResetScene', '');
    log("Received message from Unity: ${message.toString()}");
    FirebaseFirestoreService.checkIn(message.toString());

    NavigatorService.popAndPushNamed(AppRoutes.dashboardAfterCheckInScreen,
        arguments: message.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
            color: Colors.white,
            child: Center(
                child: SizedBox(
                    height: 650,
                    width: 370,
                    child: UnityWidget(
                      onUnityCreated: onUnityCreated,
                      onUnitySceneLoaded: onUnitySceneLoaded,
                      onUnityMessage: onUnityMessage,
                      fullscreen: false,
                    )))),
        bottomNavigationBar: _buildBottomAppBar(context),
        floatingActionButton: CustomFloatingButton(
          height: 65,
          width: 63,
          backgroundColor: theme.colorScheme.primary,
          child: CustomImageView(
            imagePath: ImageConstant.imgPlus,
            height: 32.5.v,
            width: 31.5.h,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 49.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgSideButton,
        margin: EdgeInsets.only(
          left: 17.h,
          top: 18.v,
          bottom: 10.v,
        ),
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "lbl_check_in".tr,
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgTrophy,
          margin: EdgeInsets.symmetric(
            horizontal: 26.h,
            vertical: 3.v,
          ),
          onTap: () {
            FirebaseAuthService.logOut();
            NavigatorService.pushNamedAndRemoveUntil(
                AppRoutes.loginWithEmailIdScreen);
          },
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildBottomAppBar(BuildContext context) {
    return CustomBottomAppBar(
      onChanged: (BottomBarEnum type) {
        NavigatorService.pushNamed(getCurrentRoute(type));
      },
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Dashboard:
        return AppRoutes.dashboardBeforeCheckInScreen;
      case BottomBarEnum.Chats:
        return AppRoutes.dahsboardBeforeCheckInContainerScreen;
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
      case AppRoutes.dahsboardBeforeCheckInContainerScreen:
        return DahsboardBeforeCheckInContainerScreen.builder(context);
      default:
        return const DefaultWidget();
    }
  }
}
