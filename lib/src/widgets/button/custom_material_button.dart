import 'package:flutter/material.dart';

import '../../src.dart';

class CustomMaterialButton extends StatelessWidget {
  /// Callback function when the button is tapped.
  final VoidCallback? onTap;

  /// The text label of the button.
  final String label;

  /// show or hide the button border.
  final bool showBorder;

  /// Elevation of the button.
  final double elevation;

  /// Radius of the button corners.
  final double radius;

  /// Height of the button.
  final double height;

  /// Width of the button.
  final double width;

  /// Icon displayed on the button.
  final dynamic icon;

  /// Icon type ['icon' or 'svg']
  final String iconType;

  /// Flag to show or hide the primary border color.
  final bool isBorderPrimary;

  /// Flag to fill the button or not.
  final bool fillButton;

  /// Color of the text
  final Color color;

  /// Color of the button
  final Color backgroundColor;

  /// Flag to disable the button.
  final bool isDisabled;

  final bool smallbutton;

  const CustomMaterialButton({
    super.key,
    this.onTap,
    required this.label,
    this.showBorder = true,
    this.elevation = 2.0,
    this.radius = 8.0,
    this.height = 50.0,
    this.width = double.infinity,
    this.icon,
    this.fillButton = true,
    this.isBorderPrimary = true,
    this.backgroundColor = AppColors.kPrimaryColor,
    this.color = AppColors.kPrimaryColor,
    this.isDisabled = false,
    this.smallbutton = false,
    this.iconType = 'icon',
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: isDisabled ? null : onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: showBorder
            ? BorderSide(
                color:
                    isBorderPrimary ? AppColors.kPrimaryColor : backgroundColor)
            : BorderSide.none,
      ),
      elevation: elevation,
      height: height,
      minWidth: width,
      color: fillButton ? backgroundColor : AppColors.white,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Utility.isAccessible(icon != null && iconType == 'svg')
                ? SvgHelper.fromSource(
                    path: icon,
                    height: 16,
                    width: 16,
                  )
                : Icon(
                    icon,
                    color: fillButton ? AppColors.white : color,
                  ),
          if (icon != null)
            Gaps.horizontalGapOf(
              8.0,
            ),
          Text(
            label,
            style: smallbutton
                ? AppStyles.text10PxRegular.copyWith(
                    color: fillButton ? AppColors.white : color,
                  )
                : AppStyles.text14PxRegular.copyWith(
                    color: fillButton ? AppColors.white : color,
                  ),
          ),
        ],
      ),
    );
  }
}
