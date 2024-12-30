import 'package:flutter/material.dart';
import 'package:smc_flutter/src/src.dart';

class BottomModelSheet {
  static void showBottomModal(BuildContext context, {required Widget child}) {
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeEight,
            vertical: Dimensions.paddingSizeEight,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radiusDefault),
              topRight: Radius.circular(Dimensions.radiusDefault),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FractionallySizedBox(
                widthFactor: 0.25,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 12.0,
                  ),
                  child: Container(
                    height: 5.0,
                    decoration: BoxDecoration(
                      color: theme.dividerColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(2.5)),
                    ),
                  ),
                ),
              ),
              Expanded(child: child),
            ],
          ),
        );
      },
    );
  }

  static void showCustomModalBottomSheet({
    required BuildContext context,
    required Widget modal,
    required bool isDarkMode,
    double radius = 16,
    bool isDrag = true,
    bool isExpanded = false,
    double paddingTop = 200,
    bool isDismissible = true,
  }) {
    showModalBottomSheet(
      isDismissible: isDismissible,
      enableDrag: isDrag,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
        ),
      ),
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height - paddingTop,
      ),
      backgroundColor: AppColors.transparent,
      context: context,
      builder: (context) => BlurWrap(
        radius: const BorderRadius.only(
          topRight: Radius.circular(Dimensions.radiusDefault),
          topLeft: Radius.circular(Dimensions.radiusDefault),
        ),
        child: Container(
          margin: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(context).bottom,
          ),
          padding:
              EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom),
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.9),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(12),
              topLeft: Radius.circular(12),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.blackColor.withOpacity(0.25),
                blurRadius: 40,
                spreadRadius: 0,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 4,
                  width: 48,
                  decoration: BoxDecoration(
                    color: AppColors.bottomSheetIconColor,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  margin: const EdgeInsets.only(
                      top: Dimensions.paddingSizeEight,
                      bottom: Dimensions.paddingSizeDefault),
                ),
                modal,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
