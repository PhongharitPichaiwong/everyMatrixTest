import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/constants.dart';
import 'custom_movies_button.dart';

// ignore: must_be_immutable
class CustomMainAppBarContent extends StatefulWidget {
  final String title;
  final Color? activeColor;
  final Function? searchOnPressed;
  final Function(int)? buttonFistOnPressed;
  final Function(int)? buttonSecondOnPressed;
  final Function(int)? buttonThirdOnPressed;
  final Function(int)? buttonFourthOnPressed;
  final Function(int)? buttonFifthOnPressed;
  final bool showSlider;
  final int? activeButtonIndex;
  Color _firstColor = kLightGrey;
  Color _secondColor = kLightGrey;
  Color _thirdColor = kLightGrey;
  Color _fourthColor = kLightGrey;
  Color _fifthColor = kLightGrey;

  CustomMainAppBarContent(
      {required this.showSlider,
      required this.title,
      this.activeButtonIndex,
      this.activeColor,
      required this.searchOnPressed,
      this.buttonFistOnPressed,
      this.buttonSecondOnPressed,
      this.buttonThirdOnPressed,
      this.buttonFourthOnPressed,
      this.buttonFifthOnPressed}) {
    if (activeButtonIndex != null) changeButtonsColor(activeButtonIndex!);
  }

  void changeButtonsColor(int index) {
    switch (index) {
      case 0:
        _firstColor = activeColor!;
        _secondColor = kLightGrey;
        _thirdColor = kLightGrey;
        _fourthColor = kLightGrey;
        _fifthColor = kLightGrey;
        break;
      case 1:
        _firstColor = kLightGrey;
        _secondColor = activeColor!;
        _thirdColor = kLightGrey;
        _fourthColor = kLightGrey;
        _fifthColor = kLightGrey;
        break;
      case 2:
        _firstColor = kLightGrey;
        _secondColor = kLightGrey;
        _thirdColor = activeColor!;
        _fourthColor = kLightGrey;
        _fifthColor = kLightGrey;
        break;
      case 3:
        _firstColor = kLightGrey;
        _secondColor = kLightGrey;
        _thirdColor = kLightGrey;
        _fourthColor = activeColor!;
        _fifthColor = kLightGrey;
        break;
      default:
        _firstColor = kLightGrey;
        _secondColor = kLightGrey;
        _thirdColor = kLightGrey;
        _fourthColor = kLightGrey;
        _fifthColor = activeColor!;
    }
  }

  @override
  _CustomMainAppBarContentState createState() =>
      _CustomMainAppBarContentState();
}

class _CustomMainAppBarContentState extends State<CustomMainAppBarContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(widget.title, style: kAppBarTitleTextStyle),
          trailing: (widget.showSlider)
              ? IconButton(
                  onPressed: () {
                    widget.searchOnPressed!();
                  },
                  icon: Icon(Icons.search, size: 22.sp),
                )
              : null,
        ),
        SizedBox(height: 3.h),
        if (widget.showSlider)
          if (widget.activeButtonIndex != null)
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.only(bottom: 2.0.h, left: 4.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomMoviesButton(
                      text: kHomeScreenButtonFirstText,
                      onPressed: () {
                        setState(() {
                          widget.buttonFistOnPressed!(0);
                        });
                      },
                      color: widget._firstColor,
                    ),
                    SizedBox(width: 5.w),
                    CustomMoviesButton(
                      text: kHomeScreenButtonSecondText,
                      onPressed: () {
                        setState(() {
                          widget.buttonSecondOnPressed!(1);
                        });
                      },
                      color: widget._secondColor,
                    ),
                    SizedBox(width: 5.w),
                    CustomMoviesButton(
                      text: kHomeScreenButtonThirdText,
                      onPressed: () {
                        setState(() {
                          widget.buttonThirdOnPressed!(2);
                        });
                      },
                      color: widget._thirdColor,
                    ),
                    SizedBox(width: 5.w),
                    CustomMoviesButton(
                      text: kHomeScreenButtonFourthText,
                      onPressed: () {
                        setState(() {
                          widget.buttonFourthOnPressed!(3);
                        });
                      },
                      color: widget._fourthColor,
                    ),
                    SizedBox(width: 5.w),
                    CustomMoviesButton(
                      text: kHomeScreenButtonFifthText,
                      onPressed: () {
                        setState(() {
                          widget.buttonFifthOnPressed!(4);
                        });
                      },
                      color: widget._fifthColor,
                    ),
                  ],
                ),
              ),
            ),
      ],
    );
  }
}
