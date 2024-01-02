import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/constants.dart';
import '../widgets/drawer_item.dart';

class DrawerScreen extends StatelessWidget {
  final Function(Color) colorChanged;
  DrawerScreen({required this.colorChanged});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: kPrimaryColor,
        child: Padding(
          padding:
              EdgeInsets.only(top: 10.h, left: 6.w, right: 6.w, bottom: 5.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.h,
              ),
              DrawerItem(
                title: kDrawerTitleSecondText,
                desc: kDrawerAboutDescText,
              ),
              SizedBox(
                height: 5.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
