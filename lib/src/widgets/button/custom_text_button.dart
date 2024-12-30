import 'package:flutter/material.dart';

import '../../src.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color? iconColor;
  final TextStyle? textStyle;
  final ButtonStyle? buttonStyle;
  final EdgeInsetsGeometry? padding;

  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.iconColor,
    this.textStyle,
    this.buttonStyle,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (icon != null) const SizedBox(width: 8.0),
            if (icon != null) // Check if iconData is provided
              Icon(
                icon,
                color: iconColor ?? Theme.of(context).primaryColor,
              ),
            if (icon != null) Gaps.horizontalGapOf(5.0),
            Text(
              text,
              style: textStyle ?? AppStyles.text16PxRegular,
            ),
          ],
        ),
      ),
    );
  }
}
