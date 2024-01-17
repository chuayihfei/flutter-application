import 'package:flutter_application_1/core/app_export.dart';
import 'package:flutter_application_1/presentation/dashboard_before_check_in_page/provider/dashboard_before_check_in_provider.dart';
import 'package:flutter_application_1/presentation/dashboard_before_check_in_page/widgets/list_item_widget.dart';
import 'package:flutter_application_1/widgets/app_bar/appbar_leading_image.dart';
import 'package:flutter_application_1/widgets/app_bar/appbar_title.dart';
import 'package:flutter_application_1/widgets/app_bar/appbar_trailing_image.dart';
import 'package:flutter_application_1/widgets/app_bar/custom_app_bar.dart';

import 'models/list_item_model.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore_for_file: must_be_immutable
class DahsboardBeforeCheckInPage extends StatefulWidget {
  const DahsboardBeforeCheckInPage({Key? key})
      : super(
          key: key,
        );

  @override
  DahsboardBeforeCheckInPageState createState() =>
      DahsboardBeforeCheckInPageState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DahsboardBeforeCheckInProvider(),
      child: const DahsboardBeforeCheckInPage(),
    );
  }
}

class DahsboardBeforeCheckInPageState
    extends State<DahsboardBeforeCheckInPage> {
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
            vertical: 18.v,
          ),
          child: Column(
            children: [
              _buildStatusBar(context),
              SizedBox(height: 13.v),
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
              SizedBox(height: 26.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 7.h),
                  child: Text(
                    "lbl_serangoon".tr,
                    style: CustomTextStyles.headlineSmallMontserratPrimary,
                  ),
                ),
              ),
              SizedBox(height: 22.v),
              _buildList(context),
              SizedBox(height: 22.v),
            ],
          ),
        ),
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
        child: Consumer<DahsboardBeforeCheckInProvider>(
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
                  provider.dahsboardBeforeCheckInModelObj.listItemList.length,
              itemBuilder: (context, index) {
                ListItemModel model =
                    provider.dahsboardBeforeCheckInModelObj.listItemList[index];
                return ListItemWidget(
                  model,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
