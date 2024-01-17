import 'package:flutter_application_1/core/app_export.dart';

import '../models/list_item_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ListItemWidget extends StatelessWidget {
  ListItemWidget(
    this.listItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  ListItemModel listItemModelObj;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 108.h,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            Container(
              height: 92.v,
              width: 108.h,
              decoration: BoxDecoration(
                color: appTheme.greenA700,
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
              listItemModelObj.concourse!,
              style: theme.textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
