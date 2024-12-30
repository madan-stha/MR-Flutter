import 'package:flutter/material.dart';

import '../src.dart';

class CustomRoundedBox extends StatelessWidget {
  final String? title;
  final color;
  final IconData? icon;
  final VoidCallback? onTap;
  final double? radius;
  const CustomRoundedBox(
      {super.key,
      required this.title,
      this.color,
      this.onTap,
      this.radius,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.cover,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              radius ?? 20.0,
            ),
            color: color.withOpacity(0.2) ??
                Theme.of(context).primaryColor.withOpacity(0.2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (icon != null)
                Icon(
                  icon ?? Icons.history_outlined,
                  size: 14,
                  color: color ?? null,
                ),
              Gaps.horizontalGapOf(5),
              Text(
                title ?? "",
                style: AppStyles.text10PxRegular.copyWith(
                  color: color ?? null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
