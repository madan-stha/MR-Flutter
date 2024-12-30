import 'package:flutter/material.dart';

import '../../src.dart';

class CustomSmallButton extends StatelessWidget {
  /// Callback function when the button is tapped.
  final VoidCallback? onTap;

  /// The text label of the button.
  final String label;

  /// show or hide the button border.
  final bool showBorder;

  /// Radius of the button corners.
  final double radius;

  /// Height of the button.
  final double height;

  /// Width of the button.
  final double width;

  /// Flag to fill the button or not.
  final bool fillButton;

  /// Color of the text
  final Color color;

  /// Color of the button
  final Color backgroundColor;

  /// Flag to disable the button.
  final bool isDisabled;

  final bool smallbutton;

  const CustomSmallButton({
    super.key,
    this.onTap,
    required this.label,
    this.showBorder = true,
    this.radius = 0,
    this.height = 35,
    this.width = 71,
    this.fillButton = true,
    this.backgroundColor = AppColors.kPrimaryColor,
    this.color = AppColors.kPrimaryColor,
    this.isDisabled = false,
    this.smallbutton = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: isDisabled ? null : onTap,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            fillButton ? backgroundColor : AppColors.white,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: smallbutton
                  ? AppStyles.text12PxRegular.copyWith(
                      color: fillButton ? AppColors.kPitchBlackColor : color,
                    )
                  : AppStyles.text14PxRegular.copyWith(
                      color: fillButton ? AppColors.kPitchBlackColor : color,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
