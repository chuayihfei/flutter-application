import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/app_export.dart';
import 'package:flutter_application_1/presentation/chats_screen/provider/chats_screen_provider.dart';
import 'package:flutter_application_1/presentation/chats_screen/widget/chat_item.dart';
import 'package:flutter_application_1/presentation/dashboard_after_check_in/dashboard_after_check_in_screen.dart';
import 'package:flutter_application_1/presentation/dashboard_before_check_in_screen/dashboard_before_check_in_screen.dart';
import 'package:flutter_application_1/provider/firebase_provider.dart';
import 'package:flutter_application_1/services/firebase_firestore_service.dart';
import 'package:flutter_application_1/services/notification_service.dart';
import 'package:flutter_application_1/widgets/app_bar/appbar_leading_image.dart';
import 'package:flutter_application_1/widgets/app_bar/appbar_title.dart';
import 'package:flutter_application_1/widgets/app_bar/appbar_trailing_image.dart';
import 'package:flutter_application_1/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter_application_1/widgets/custom_bottom_app_bar.dart';
import 'package:flutter_application_1/widgets/custom_elevated_button.dart';
import 'package:flutter_application_1/widgets/custom_floating_button.dart';
import 'package:flutter_application_1/widgets/custom_search_view.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key})
      : super(
          key: key,
        );

  @override
  ChatsScreenState createState() => ChatsScreenState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatsProvider(),
      child: const ChatsScreen(),
    );
  }
}

class ChatsScreenState extends State<ChatsScreen> with WidgetsBindingObserver {
  final notificationService = NotificationService();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  bool? checkdIn;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    Provider.of<FirebaseProvider>(context, listen: false).getAllChats();
    Provider.of<FirebaseProvider>(context, listen: false)
        .getUserById(FirebaseAuth.instance.currentUser!.uid)
        .then((value) {
      checkdIn = value?.checkedIn;
    });
    notificationService.firebaseNotification(context);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        FirebaseFirestoreService.updateUserData({
          'lastActive': DateTime.now(),
          'isOnline': true,
        });
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
      case AppLifecycleState.detached:
        FirebaseFirestoreService.updateUserData({'isOnline': false});
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 12.h,
            vertical: 25.v,
          ),
          child: Column(
            children: [
              buildSearch(context),
              SizedBox(height: 45.v),
              buildChats(context),
              SizedBox(height: 45.v),
            ],
          ),
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

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 56.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgSideButton,
        margin: EdgeInsets.only(
          left: 24.h,
          top: 18.v,
          bottom: 10.v,
        ),
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "lbl_chats".tr,
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgTrophy,
          margin: EdgeInsets.symmetric(
            horizontal: 19.h,
            vertical: 3.v,
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget buildSearch(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 11.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Selector<ChatsProvider, TextEditingController?>(
              selector: (
                context,
                provider,
              ) =>
                  provider.searchController,
              builder: (context, searchController, child) {
                return CustomSearchView(
                  controller: searchController,
                  hintText: "lbl_search".tr,
                  onChanged: (val) =>
                      Provider.of<FirebaseProvider>(context, listen: false)
                          .searchUser(val),
                );
              },
            ),
          ),
          CustomElevatedButton(
            height: 40.v,
            width: 40.h,
            text: "lbl".tr,
            margin: EdgeInsets.only(left: 8.h),
            buttonStyle: CustomButtonStyles.fillPrimary,
            buttonTextStyle: CustomTextStyles.titleLargeRobotoOnPrimary,
            onPressed: () {
              NavigatorService.pushNamed(AppRoutes.newChatScreen);
            },
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget buildChats(BuildContext context) {
    return Consumer<FirebaseProvider>(builder: (context, value, child) {
      return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: value.chats.length,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          // if (value.users[index].uid ==
          //     FirebaseAuth.instance.currentUser?.uid) {
          //   user = value.users[index];
          // }
          return value.chats[index].usersId
                  .contains(FirebaseAuth.instance.currentUser?.uid)
              ? ChatItem(chat: value.chats[index])
              : const SizedBox();
        },
      );
    });
  }

  /// Section Widget
  Widget _buildBottomAppBar(BuildContext context) {
    return CustomBottomAppBar(
      onChanged: (BottomBarEnum type) {
        switch (type) {
          case BottomBarEnum.Dashboard:
            NavigatorService.goBack();
          case BottomBarEnum.Chats:
            NavigatorService.pushNamed(getCurrentRoute(type));
        }
      },
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Dashboard:
      // {
      //   if (!checkdIn!) {
      //     return AppRoutes.dashboardBeforeCheckInScreen;
      //   } else {
      //     return AppRoutes.dashboardAfterCheckInScreen;
      //   }
      // }
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
      case AppRoutes.dashboardAfterCheckInScreen:
        return DashboardAfterCheckInScreen.builder(context);
      case AppRoutes.chatsScreen:
        return ChatsScreen.builder(context);
      default:
        return const DefaultWidget();
    }
  }
}
