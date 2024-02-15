import 'package:flutter_application_1/core/app_export.dart';

import '../models/before_substation_list_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BeforeSubstationListWidget extends StatelessWidget {
  BeforeSubstationListWidget(
    this.listItemModelObj,
    this.color,
    this.location, {
    Key? key,
  }) : super(
          key: key,
        );

  BeforeSubstationListModel listItemModelObj;
  Color color;
  String location;

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
              listItemModelObj.name!,
              style: theme.textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
