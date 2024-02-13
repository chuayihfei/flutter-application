import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/app_export.dart';
import 'package:flutter_application_1/presentation/dashboard_after_check_in/models/list_item_model.dart';

// ignore: must_be_immutable
class List1ItemWidget extends StatelessWidget {
  List1ItemWidget(
    this.list1ItemModelObj,
    this.color, {
    Key? key,
  }) : super(
          key: key,
        );

  List1ItemModel list1ItemModelObj;
  Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 108.h,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            Container(
              height: 88.v,
              width: 108.h,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(
                  10.h,
                ),
                boxShadow: [
                  BoxShadow(
                    color: appTheme.indigoA20033,
                    spreadRadius: 2.h,
                    blurRadius: 2.h,
                    offset: const Offset(
                      0,
                      4,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              list1ItemModelObj.concourse!,
              style: theme.textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
