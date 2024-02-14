// ignore_for_file: use_build_context_synchronously
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/app_export.dart';
import 'package:flutter_application_1/presentation/way_finder_screen/provider/way_finder_provider.dart';
import 'package:flutter_application_1/screens/home_screens/home_screen_before.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:permission_handler/permission_handler.dart';

class WayFinderScreen extends StatefulWidget {
  const WayFinderScreen({Key? key}) : super(key: key);

  @override
  State<WayFinderScreen> createState() => WayFinderScreenState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WayFinderProvider(),
      child: const WayFinderScreen(),
    );
  }
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
  }

  void changeToWayFinderScene() {
    log("Changed Unity Scene to Way Finder");

    _unityWidgetController?.postMessage(
        'AR Session', 'LoadSceneSingle', 'SerangoonMRT');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Way Finder"),
        ),
        body: SafeArea(
            bottom: false,
            child: WillPopScope(
              onWillPop: () async {
                // Pop the category page if Android back button is pressed.
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const HomeScreenBefore()));
                return true;
              },
              child: Container(
                color: Colors.green,
                child: UnityWidget(
                  onUnityCreated: onUnityCreated,
                  onUnitySceneLoaded: onUnitySceneLoaded,
                  fullscreen: false,
                ),
              ),
            )));
  }
}
