import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/app_export.dart';
import 'package:flutter_application_1/presentation/dashboard_before_check_in_page/dashboard_before_check_in_page.dart';
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
                    padding: EdgeInsets.symmetric(horizontal: 16.h),
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
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: 719.v,
                            width: 242.h,
                            margin: EdgeInsets.only(right: 26.h),
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 71.h),
                                    child: SizedBox(
                                      height: 719.v,
                                      child: VerticalDivider(
                                        width: 5.h,
                                        thickness: 5.v,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 29.adaptSize,
                                        width: 29.adaptSize,
                                        decoration: BoxDecoration(
                                          color: theme.colorScheme.onPrimary,
                                          borderRadius: BorderRadius.circular(
                                            14.h,
                                          ),
                                          border: Border.all(
                                            color: appTheme.black900,
                                            width: 3.h,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 12.h,
                                          top: 2.v,
                                        ),
                                        child: Text(
                                          "lbl_punggol".tr,
                                          style: theme.textTheme.headlineSmall,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 30.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              height: 29.adaptSize,
                                              width: 29.adaptSize,
                                              margin:
                                                  EdgeInsets.only(bottom: 1.v),
                                              decoration: BoxDecoration(
                                                color:
                                                    theme.colorScheme.onPrimary,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  14.h,
                                                ),
                                                border: Border.all(
                                                  color: appTheme.black900,
                                                  width: 3.h,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 14.h,
                                                top: 3.v,
                                              ),
                                              child: Text(
                                                "lbl_sengkang".tr,
                                                style: theme
                                                    .textTheme.headlineSmall,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 15.v),
                                      Padding(
                                        padding: EdgeInsets.only(right: 29.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              height: 29.adaptSize,
                                              width: 29.adaptSize,
                                              decoration: BoxDecoration(
                                                color:
                                                    theme.colorScheme.onPrimary,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  14.h,
                                                ),
                                                border: Border.all(
                                                  color: appTheme.black900,
                                                  width: 3.h,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 11.h),
                                              child: Text(
                                                "lbl_buangkok".tr,
                                                style: theme
                                                    .textTheme.headlineSmall,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 17.v),
                                      Padding(
                                        padding: EdgeInsets.only(right: 42.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              height: 29.adaptSize,
                                              width: 29.adaptSize,
                                              decoration: BoxDecoration(
                                                color:
                                                    theme.colorScheme.onPrimary,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  14.h,
                                                ),
                                                border: Border.all(
                                                  color: appTheme.black900,
                                                  width: 3.h,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 12.h),
                                              child: Text(
                                                "lbl_hougang".tr,
                                                style: theme
                                                    .textTheme.headlineSmall,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 16.v),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 2.v),
                                              child: Text(
                                                "lbl_1_3".tr,
                                                style: CustomTextStyles
                                                    .headlineSmallBlack900,
                                              ),
                                            ),
                                            Container(
                                              height: 29.adaptSize,
                                              width: 29.adaptSize,
                                              margin:
                                                  EdgeInsets.only(left: 24.h),
                                              decoration: BoxDecoration(
                                                color: appTheme.redA700,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  14.h,
                                                ),
                                                border: Border.all(
                                                  color: appTheme.black900,
                                                  width: 3.h,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 11.h,
                                                bottom: 2.v,
                                              ),
                                              child: Text(
                                                "lbl_kovan".tr,
                                                style: CustomTextStyles
                                                    .headlineSmallBlack900,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 16.v),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 2.v),
                                              child: Text(
                                                "lbl_3_3".tr,
                                                style: CustomTextStyles
                                                    .headlineSmallBlack900,
                                              ),
                                            ),
                                            Container(
                                              height: 29.adaptSize,
                                              width: 29.adaptSize,
                                              margin:
                                                  EdgeInsets.only(left: 19.h),
                                              decoration: BoxDecoration(
                                                color: appTheme.greenA700,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  14.h,
                                                ),
                                                border: Border.all(
                                                  color: appTheme.black900,
                                                  width: 3.h,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 13.h,
                                                top: 2.v,
                                              ),
                                              child: Text(
                                                "lbl_serangoon".tr,
                                                style: CustomTextStyles
                                                    .headlineSmallBlack900,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 14.v),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 3.v),
                                              child: Text(
                                                "lbl_2_3".tr,
                                                style: CustomTextStyles
                                                    .headlineSmallBlack900,
                                              ),
                                            ),
                                            Container(
                                              height: 29.adaptSize,
                                              width: 29.adaptSize,
                                              margin:
                                                  EdgeInsets.only(left: 19.h),
                                              decoration: BoxDecoration(
                                                color: appTheme.orange700,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  14.h,
                                                ),
                                                border: Border.all(
                                                  color: appTheme.black900,
                                                  width: 3.h,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 10.h,
                                                top: 2.v,
                                                bottom: 1.v,
                                              ),
                                              child: Text(
                                                "lbl_woodleigh".tr,
                                                style: CustomTextStyles
                                                    .headlineSmallBlack900,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 17.v),
                                      Padding(
                                        padding: EdgeInsets.only(right: 4.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              height: 29.adaptSize,
                                              width: 29.adaptSize,
                                              decoration: BoxDecoration(
                                                color:
                                                    theme.colorScheme.onPrimary,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  14.h,
                                                ),
                                                border: Border.all(
                                                  color: appTheme.black900,
                                                  width: 3.h,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 11.h),
                                              child: Text(
                                                "lbl_potong_pasir".tr,
                                                style: theme
                                                    .textTheme.headlineSmall,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 17.v),
                                      Padding(
                                        padding: EdgeInsets.only(right: 22.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              height: 29.adaptSize,
                                              width: 29.adaptSize,
                                              decoration: BoxDecoration(
                                                color:
                                                    theme.colorScheme.onPrimary,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  14.h,
                                                ),
                                                border: Border.all(
                                                  color: appTheme.black900,
                                                  width: 3.h,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 11.h),
                                              child: Text(
                                                "lbl_boon_keng".tr,
                                                style: theme
                                                    .textTheme.headlineSmall,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 17.v),
                                      Padding(
                                        padding: EdgeInsets.only(right: 15.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              height: 29.adaptSize,
                                              width: 29.adaptSize,
                                              decoration: BoxDecoration(
                                                color:
                                                    theme.colorScheme.onPrimary,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  14.h,
                                                ),
                                                border: Border.all(
                                                  color: appTheme.black900,
                                                  width: 3.h,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 13.h),
                                              child: Text(
                                                "lbl_farrer_road".tr,
                                                style: theme
                                                    .textTheme.headlineSmall,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 15.v),
                                      Padding(
                                        padding: EdgeInsets.only(right: 30.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              height: 29.adaptSize,
                                              width: 29.adaptSize,
                                              margin: EdgeInsets.only(top: 1.v),
                                              decoration: BoxDecoration(
                                                color:
                                                    theme.colorScheme.onPrimary,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  14.h,
                                                ),
                                                border: Border.all(
                                                  color: appTheme.black900,
                                                  width: 3.h,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 10.h,
                                                bottom: 3.v,
                                              ),
                                              child: Text(
                                                "lbl_little_india".tr,
                                                style: theme
                                                    .textTheme.headlineSmall,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 17.v),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            height: 29.adaptSize,
                                            width: 29.adaptSize,
                                            decoration: BoxDecoration(
                                              color:
                                                  theme.colorScheme.onPrimary,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                14.h,
                                              ),
                                              border: Border.all(
                                                color: appTheme.black900,
                                                width: 3.h,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 11.h),
                                            child: Text(
                                              "lbl_dhoby_ghaut".tr,
                                              style:
                                                  theme.textTheme.headlineSmall,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 17.v),
                                      Padding(
                                        padding: EdgeInsets.only(right: 20.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              height: 29.adaptSize,
                                              width: 29.adaptSize,
                                              decoration: BoxDecoration(
                                                color:
                                                    theme.colorScheme.onPrimary,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  14.h,
                                                ),
                                                border: Border.all(
                                                  color: appTheme.black900,
                                                  width: 3.h,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10.h),
                                              child: Text(
                                                "lbl_clark_quay".tr,
                                                style: theme
                                                    .textTheme.headlineSmall,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 16.v),
                                      Padding(
                                        padding: EdgeInsets.only(right: 23.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              height: 29.adaptSize,
                                              width: 29.adaptSize,
                                              decoration: BoxDecoration(
                                                color:
                                                    theme.colorScheme.onPrimary,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  14.h,
                                                ),
                                                border: Border.all(
                                                  color: appTheme.black900,
                                                  width: 3.h,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 12.h,
                                                bottom: 2.v,
                                              ),
                                              child: Text(
                                                "lbl_chinatown".tr,
                                                style: theme
                                                    .textTheme.headlineSmall,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 14.v),
                                      Padding(
                                        padding: EdgeInsets.only(right: 3.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              height: 29.adaptSize,
                                              width: 29.adaptSize,
                                              margin: EdgeInsets.only(top: 2.v),
                                              decoration: BoxDecoration(
                                                color:
                                                    theme.colorScheme.onPrimary,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  14.h,
                                                ),
                                                border: Border.all(
                                                  color: appTheme.black900,
                                                  width: 3.h,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 9.h,
                                                bottom: 4.v,
                                              ),
                                              child: Text(
                                                "lbl_outram_park".tr,
                                                style: theme
                                                    .textTheme.headlineSmall,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 1.h),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          height: 29.adaptSize,
                                          width: 29.adaptSize,
                                          margin: EdgeInsets.only(top: 3.v),
                                          decoration: BoxDecoration(
                                            color: theme.colorScheme.onPrimary,
                                            borderRadius: BorderRadius.circular(
                                              14.h,
                                            ),
                                            border: Border.all(
                                              color: appTheme.black900,
                                              width: 3.h,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 10.h,
                                            bottom: 5.v,
                                          ),
                                          child: Text(
                                            "lbl_harbourfront".tr,
                                            style:
                                                theme.textTheme.headlineSmall,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
      color: Colors.purple,
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
        return "/";
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
        return DahsboardBeforeCheckInPage.builder(context);
      default:
        return DefaultWidget();
    }
  }
}
