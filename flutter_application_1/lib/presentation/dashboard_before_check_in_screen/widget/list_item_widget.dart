import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/core/app_export.dart';
import 'package:flutter_application_1/presentation/substations_before_check_in_screen/substations_before_check_in_screen.dart';
import 'package:flutter_application_1/presentation/dashboard_before_check_in_screen/models/list_item_model.dart';

// ignore: must_be_immutable
class ListItemWidget extends StatelessWidget {
  ListItemWidget(
    this.listItemModelObj,
    this.capacity,
    this.noOfPeople,
    this.available, {
    Key? key,
  }) : super(key: key);

  ListItemModel listItemModelObj;
  int capacity;
  int noOfPeople;
  bool available;

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
    return GestureDetector(
      onTap: () {
        if (!available) {
        } else {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => SubstationsBeforeCheckInScreen(
                      location: listItemModelObj.name!)));
        }
      },
      child: Align(
        alignment: Alignment.topLeft,
        child: available ? buildAvailable() : buildNotAvailable(),
      ),
    );
  }

  Widget buildAvailable() {
    return Padding(
        padding: EdgeInsets.only(right: 10.h),
        child: Row(children: [
          SizedBox(
              width: 70.adaptSize,
              child: Padding(
                  padding: EdgeInsets.only(
                    top: 2.v,
                  ),
                  child: Text(
                    '$noOfPeople/$capacity',
                    style: CustomTextStyles.headlineSmallBlack900,
                  ))),
          Container(
            height: 29.adaptSize,
            width: 29.adaptSize,
            decoration: BoxDecoration(
              color: getCapacityColor(capacity, noOfPeople),
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
              listItemModelObj.name!.capitalize(),
              style: CustomTextStyles.headlineSmallBlack900,
            ),
          )
        ]));
  }

  Widget buildNotAvailable() {
    return Padding(
        padding: EdgeInsets.only(left: 68.h),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(children: [
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
                    listItemModelObj.name!.capitalize(),
                    style: theme.textTheme.headlineSmall,
                  ),
                )
              ])
            ]));
  }
}
