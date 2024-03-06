// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/app_export.dart';
import 'package:flutter_application_1/presentation/way_finder_screen/provider/way_finder_provider.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_application_1/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter_application_1/widgets/custom_bottom_app_bar.dart';
import 'package:flutter_application_1/widgets/custom_floating_button.dart';
import 'package:flutter_application_1/widgets/app_bar/appbar_leading_image.dart';
import 'package:flutter_application_1/widgets/app_bar/appbar_title.dart';
import 'package:flutter_application_1/widgets/app_bar/appbar_trailing_image.dart';
import 'package:flutter_application_1/presentation/dashboard_after_check_in/dashboard_after_check_in_screen.dart';
import 'package:flutter_application_1/widgets/settings_drawer.dart';

class WayFinderScreen extends StatefulWidget {
  const WayFinderScreen({super.key, required this.destination});

  final String destination;
  @override
  State<WayFinderScreen> createState() => WayFinderScreenState();
}

class WayFinderScreenState extends State<WayFinderScreen> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  UnityWidgetController? _unityWidgetController;

  @override
  void initState() {
    super.initState();
    //WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //  changeToWayFinderScene();
    //});
  }

  void onUnityCreated(controller) async {
    _unityWidgetController = controller;

    const permission = Permission.camera;

    if (await permission.isDenied) {
      await permission.request();
    }

    changeToWayFinderScene();
  }

  void onUnitySceneLoaded(SceneLoaded? sceneInfo) {
    if (sceneInfo != null) {
      log('Received scene loaded from unity: ${sceneInfo.name}');
      log('Received scene loaded from unity buildIndex: ${sceneInfo.buildIndex}');
    }

    switch (widget.destination) {
      case 'Concourse':
        {
          _unityWidgetController?.postMessage(
              'LineSettings', 'SetDestinationPoint', '5');
        }
      case 'Platform':
        {
          _unityWidgetController?.postMessage(
              'LineSettings', 'SetDestinationPoint', '6');
        }
      case 'Ground':
        {
          _unityWidgetController?.postMessage(
              'LineSettings', 'SetDestinationPoint', '15');
        }
    }
  }

  void changeToWayFinderScene() {
    log("Changed Unity Scene to Way Finder");

    _unityWidgetController?.postMessage(
        'AR Session', 'LoadSceneSingle', 'SerangoonMRT');
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
        drawer: SettingsDrawer(
          sendMessageToUnity: (String message) {
            switch (message) {
              case 'Toggle Line Settings Panel':
                {
                  _unityWidgetController?.postMessage(
                      'LineSettingsToggle', 'activeSetting', message);
                }
              case 'Help UI':
                {
                  _unityWidgetController?.postMessage(
                      'HelpUIToggle', 'activeSetting', message);
                }
              case 'Show Minimap':
                {
                  _unityWidgetController?.postMessage(
                      'MinimapToggle', 'activeSetting', message);
                }
              case 'Reset Environment':
                {
                  _unityWidgetController?.postMessage(
                      'ResetEnvironment', 'RestartCurrentMap', message);
                }
            }
          },
        ),
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

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 49.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgSettings,
        margin: EdgeInsets.only(
          left: 17.h,
          top: 18.v,
          bottom: 10.v,
        ),
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Way Finder".tr,
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgTrophy,
          margin: EdgeInsets.symmetric(
            horizontal: 26.h,
            vertical: 3.v,
          ),
        ),
      ],
    );
  }

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
        return AppRoutes.dashboardAfterCheckInScreen;
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
      case AppRoutes.dashboardAfterCheckInScreen:
        return DashboardAfterCheckInScreen.builder(context);
      default:
        return const DefaultWidget();
    }
  }

  //Unity reply message handler
  void onUnityMessage(message) async {
    log("Received message from Unity: ${message.toString()}");

    switch (message) {
      case 'VideoCube':
        {
          //does smth
        }
      case 'DestinationAreaCube':
        {
          //destination reached
        }
    }
  }
}
