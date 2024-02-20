import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/core/app_export.dart';
import 'package:flutter_application_1/presentation/substations_before_check_in_screen/provider/substations_before_check_in_provider.dart';
import 'package:flutter_application_1/presentation/substations_before_check_in_screen/widgets/substations_before_check_in_widget.dart';
import 'package:flutter_application_1/services/firebase_auth_service.dart';
import 'package:flutter_application_1/widgets/app_bar/appbar_leading_image.dart';
import 'package:flutter_application_1/widgets/app_bar/appbar_title.dart';
import 'package:flutter_application_1/widgets/app_bar/appbar_trailing_image.dart';
import 'package:flutter_application_1/widgets/app_bar/custom_app_bar.dart';

import 'models/before_substation_list_model.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore_for_file: must_be_immutable
class SubstationsBeforeCheckInScreen extends StatefulWidget {
  const SubstationsBeforeCheckInScreen({super.key, required this.location});

  final String location;

  @override
  State<SubstationsBeforeCheckInScreen> createState() =>
      DahsboardBeforeCheckInPageState();
}

class DahsboardBeforeCheckInPageState
    extends State<SubstationsBeforeCheckInScreen> {
  @override
  void initState() {
    super.initState();
  }

  Color getCapacityColor(int capacity, int checkedIn) {
    double result = checkedIn / capacity;

    if (result == 1) {
      return appTheme.greenA700;
    } else if (result >= 0.5) {
      return appTheme.orange700;
    } else {
      return appTheme.redA700;
    }
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
  Widget _buildSlider(BuildContext context) {
    return Container();
  }

  /// Section Widget
  Widget _buildList(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
            height: 113.v,
            child: Consumer<SubstationsBeforeCheckInProvider>(
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
                    itemCount: provider
                        .dahsboardBeforeCheckInModelObj.listItemList.length,
                    itemBuilder: (context, index) {
                      return StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('locations')
                            .doc(widget.location)
                            .collection("substations")
                            .doc(provider.dahsboardBeforeCheckInModelObj
                                .listItemList[index].name)
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<DocumentSnapshot> snpshot) {
                          if (snpshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          BeforeSubstationListModel model = provider
                              .dahsboardBeforeCheckInModelObj
                              .listItemList[index];

                          return BeforeSubstationListWidget(
                              model,
                              getCapacityColor(
                                  (snpshot.data!.data()
                                      as Map<String, dynamic>)['capacity'],
                                  (snpshot.data!.data() as Map<String,
                                      dynamic>)['number of people']),
                              widget.location);
                        },
                      );
                    });
              },
            )));
  }
}
