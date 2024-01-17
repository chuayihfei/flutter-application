import 'package:flutter_application_1/core/app_export.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/dashboard_after_check_in/models/list_item_model.dart';
import 'package:flutter_application_1/presentation/dashboard_after_check_in/provider/dashboard_after_check_in_provider.dart';
import 'package:flutter_application_1/presentation/dashboard_after_check_in/widgets/list_item_widget.dart';
import 'package:flutter_application_1/presentation/dashboard_before_check_in_page/dashboard_before_check_in_page.dart';
import 'package:flutter_application_1/widgets/app_bar/appbar_leading_image.dart';
import 'package:flutter_application_1/widgets/app_bar/appbar_title.dart';
import 'package:flutter_application_1/widgets/app_bar/appbar_trailing_image.dart';
import 'package:flutter_application_1/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter_application_1/widgets/custom_button_app_bar.dart';
import 'package:flutter_application_1/widgets/custom_floating_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DashboardAfterCheckInScreen extends StatefulWidget {
  const DashboardAfterCheckInScreen({Key? key})
      : super(
          key: key,
        );

  @override
  DashboardAfterCheckInScreenState createState() =>
      DashboardAfterCheckInScreenState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DashboardAfterCheckInProvider(),
      child: DashboardAfterCheckInScreen(),
    );
  }
}

class DashboardAfterCheckInScreenState
    extends State<DashboardAfterCheckInScreen> {
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
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 13.h,
            vertical: 6.v,
          ),
          child: Column(
            children: [
              _buildStatusBar(context),
              SizedBox(height: 25.v),
              _buildSlider(context),
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
              SizedBox(height: 23.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 7.h),
                  child: Text(
                    "lbl_location".tr,
                    style: CustomTextStyles.headlineSmallMontserratPrimary,
                  ),
                ),
              ),
              SizedBox(height: 25.v),
              _buildList(context),
              SizedBox(height: 25.v),
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
        text: "lbl_dashboard".tr,
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

  /// Section Widget
  Widget _buildStatusBar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 9.h),
      padding: EdgeInsets.symmetric(
        horizontal: 157.h,
        vertical: 22.v,
      ),
      decoration: AppDecoration.outlineBlack900.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Text(
        "lbl_kovan".tr,
        style: CustomTextStyles.headlineSmallMontserratBlack900,
      ),
    );
  }

  /// Section Widget
  Widget _buildSlider(BuildContext context) {
    return Container();
  }

  /// Section Widget
  Widget _buildList(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 113.v,
        child: Consumer<DashboardAfterCheckInProvider>(
          builder: (context, provider, child) {
            return ListView.separated(
              padding: EdgeInsets.only(
                left: 7.h,
                right: 23.h,
              ),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (
                context,
                index,
              ) {
                return SizedBox(
                  width: 24.h,
                );
              },
              itemCount:
                  provider.dashboardAfterCheckInModelObj.list1ItemList.length,
              itemBuilder: (context, index) {
                List1ItemModel model =
                    provider.dashboardAfterCheckInModelObj.list1ItemList[index];
                return List1ItemWidget(
                  model,
                );
              },
            );
          },
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomAppBar(BuildContext context) {
    return CustomBottomAppBar(
      onChanged: (BottomBarEnum type) {
        Navigator.pushNamed(
            navigatorKey.currentContext!, getCurrentRoute(type));
      },
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Dashboard:
        return "/";
      case BottomBarEnum.Chats:
        return AppRoutes.dahsboardBeforeCheckInPage;
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
        return const DefaultWidget();
    }
  }
}
