import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/app_export.dart';
import 'package:flutter_application_1/presentation/chats_screen/chats_screen.dart';
import 'package:flutter_application_1/presentation/dashboard_before_check_in_screen/models/list_item_model.dart';
import 'package:flutter_application_1/presentation/dashboard_before_check_in_screen/widget/list_item_widget.dart';
import 'package:flutter_application_1/services/firebase_auth_service.dart';
import 'package:flutter_application_1/widgets/app_bar/appbar_leading_image.dart';
import 'package:flutter_application_1/widgets/app_bar/appbar_title.dart';
import 'package:flutter_application_1/widgets/app_bar/appbar_trailing_image.dart';
import 'package:flutter_application_1/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter_application_1/widgets/custom_bottom_app_bar.dart';
import 'package:flutter_application_1/widgets/custom_floating_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'provider/dashboard_before_check_in_provider.dart';

class DashboardBeforeCheckInScreen extends StatefulWidget {
  const DashboardBeforeCheckInScreen({Key? key})
      : super(
          key: key,
        );

  @override
  DashboardBeforeCheckInScreenState createState() =>
      DashboardBeforeCheckInScreenState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DashboardBeforeCheckInProvider(),
      child: const DashboardBeforeCheckInScreen(),
    );
  }
}

class DashboardBeforeCheckInScreenState
    extends State<DashboardBeforeCheckInScreen> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 23.v),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 59.v),
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Column(
                      children: [
                        _buildStatusBar(context),
                        SizedBox(height: 17.v),
                        _buildCard(context),
                        SizedBox(height: 28.v),
                        SizedBox(
                          height: 7.v,
                          child: AnimatedSmoothIndicator(
                            activeIndex: 0,
                            count: 3,
                            effect: ScrollingDotsEffect(
                              spacing: 2,
                              activeDotColor: theme.colorScheme.primary,
                              dotColor: appTheme.blueGray100,
                              dotHeight: 7.v,
                              dotWidth: 10.h,
                            ),
                          ),
                        ),
                        SizedBox(height: 36.v),
                        buildListMap(context),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomAppBar(context),
        floatingActionButton: CustomFloatingButton(
          height: 65,
          width: 63,
          backgroundColor: theme.colorScheme.primary,
          child: const Icon(Icons.add, color: Colors.white, size: 37.5),
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
        text: "lbl_dashboard".tr,
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgTrophy,
          margin: EdgeInsets.symmetric(
            horizontal: 19.h,
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
  Widget _buildStatusBar(BuildContext context) {
    return GestureDetector(
        onTap: () {
          NavigatorService.pushNamed(AppRoutes.checkInScreen);
        },
        child: Container(
          margin: EdgeInsets.only(left: 3.h),
          padding: EdgeInsets.symmetric(
            horizontal: 97.h,
            vertical: 19.v,
          ),
          decoration: AppDecoration.outlineBlack.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder10,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 5.v),
              Text(
                "lbl_not_checked_in".tr,
                style: CustomTextStyles.headlineSmallMontserratPrimary,
              ),
            ],
          ),
        ));
  }

  /// Section Widget
  Widget _buildCard(BuildContext context) {
    return Container(
      color: Colors.green,
    );
  }

  Widget buildListMap(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: Container(
            height: 635.v,
            width: 350.h,
            margin: EdgeInsets.only(left: 100.h),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 80.h),
                    child: SizedBox(
                      height: 635.v,
                      child: VerticalDivider(
                        width: 5.h,
                        thickness: 5.v,
                      ),
                    ),
                  ),
                ),
                Consumer<DashboardBeforeCheckInProvider>(
                    builder: (context, provider, child) {
                  return ListView.separated(
                    itemCount: provider
                        .dashboardBeforeCheckInModelObj.listItemList.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('locations')
                              .doc(provider.dashboardBeforeCheckInModelObj
                                  .listItemList[index].name)
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }
                            ListItemModel model = provider
                                .dashboardBeforeCheckInModelObj
                                .listItemList[index];
                            return ListItemWidget(
                                model,
                                (snapshot.data!.data()
                                    as Map<String, dynamic>)['capacity'],
                                (snapshot.data!.data() as Map<String, dynamic>)[
                                    'number of people'],
                                (snapshot.data!.data()
                                    as Map<String, dynamic>)['available']);
                          });
                    },
                  );
                })
              ],
            )));
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
      case AppRoutes.dahsboardBeforeCheckInPage:
        return DashboardBeforeCheckInScreen.builder(context);
      case AppRoutes.chatsScreen:
        return ChatsScreen.builder(context);
      default:
        return const DefaultWidget();
    }
  }
}
