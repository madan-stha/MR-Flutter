import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smc_flutter/src/src.dart';

class DialogManager {
  static void showModalDialouge(
    BuildContext context,
    String? title,
    bool isLoader,
    Map<String, dynamic> body,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return Dialog(
          surfaceTintColor: Theme.of(context).canvasColor,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isLoader) const CircularProgressIndicator.adaptive(),
                const SizedBox(
                  width: 30,
                ),
                if (isLoader)
                  Text(
                    body['text'],
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void customDialog(
    BuildContext context, {
    String? image,
    String? imageType,
    String? title,
    String? description,
    bool isDismissible = true,
    bool useSafeArea = false,
    action,
  }) {
    showDialog(
      context: context,
      barrierDismissible: isDismissible,
      useSafeArea: useSafeArea,
      traversalEdgeBehavior: TraversalEdgeBehavior.closedLoop,
      builder: (context) => BlurWrap(
        blur: 1,
        child: Dialog(
          surfaceTintColor: Theme.of(context).canvasColor,
          insetAnimationCurve: Curves.easeInOut,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeLarge,
              // vertical: Dimensions.paddingSizeSmall,
            ),
            margin: const EdgeInsets.all(
              Dimensions.paddingSizeDefault,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                Dimensions.radiusDefault,
              ),
              color: Theme.of(context).canvasColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                imageType == 'lottie'
                    ? Lottie.asset(
                        image ?? Assets.courier,
                        height: Dimensions.lottieSize,
                        width: Dimensions.lottieSize,
                      )
                    : SvgHelper.fromSource(
                        path: image ?? Assets.courier,
                        type: SvgSourceType.asset,
                        height: Dimensions.dialogSvgSize,
                        width: Dimensions.dialogSvgSize,
                      ),
                Gaps.verticalGapOf(
                  5.0,
                ),
                Text(
                  title ?? "",
                  style: AppStyles.text16PxMedium,
                ),
                Gaps.verticalGapOf(
                  5.0,
                ),
                Text(
                  description ?? "",
                  style: AppStyles.text12PxRegular,
                  textAlign: TextAlign.center,
                ),
                Gaps.verticalGapOf(
                  20.0,
                ),
                if (action != null) action,
              ],
            ),
          ),
        ),
      ),
    );
  }

  static confirmationDialog(
    BuildContext context, {
    String? icon,
    String? title,
    String? description,
    Function()? onYesPressed,
    bool isLogOut = false,
    double? iconSize,
    Color? iconColor,
    Function? onNoPressed,
    Widget? widget,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          surfaceTintColor: Theme.of(context).canvasColor,
          insetPadding: const EdgeInsets.all(30),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: SizedBox(
            width: 500,
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
              child: widget ??
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.all(Dimensions.paddingSizeLarge),
                        child: SvgHelper.fromSource(
                          path: icon!,
                          width: iconSize ?? Dimensions.svgSize,
                          height: iconSize ?? Dimensions.svgSize,
                          color: iconColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeLarge,
                        ),
                        child: Text(
                          title ?? "Logout",
                          textAlign: TextAlign.center,
                          style: AppStyles.text16PxMedium.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeDefault,
                          vertical: Dimensions.paddingSizeSmall,
                        ),
                        child: Text(
                          description ?? "Are you sure to logout?",
                          style: AppStyles.text12PxMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      _buildLogOutButtons(
                          context, isLogOut, onYesPressed, onNoPressed)
                    ],
                  ),
            ),
          ),
        );
      },
    );
  }

  static Widget _buildLogOutButtons(
      BuildContext context, bool isLogOut, onYesPressed, onNoPressed) {
    return isLogOut
        ? Row(
            children: [
              Expanded(
                child: CustomMaterialButton(
                  label: AppString.cancel,
                  fillButton: false,
                  elevation: 0,
                  onTap: () => onNoPressed != null
                      ? onNoPressed()
                      : Navigator.of(context).pop(),
                  radius: Dimensions.radiusDefault,
                  height: 35,
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: CustomMaterialButton(
                  label: AppString.yesLogout,
                  onTap: () => onYesPressed!(),
                  radius: Dimensions.radiusDefault,
                  elevation: 0,
                  height: 35,
                ),
              ),
            ],
          )
        : Container();
  }

  static permissionDialog(context, {bool isDenied = false, onPressed}) {
    return AlertDialog(
      surfaceTintColor: Theme.of(context).canvasColor,
      title: Text(
        AppString.alert,
        textAlign: TextAlign.center,
        style: AppStyles.text16PxMedium,
      ),
      alignment: Alignment.center,
      actionsAlignment: MainAxisAlignment.center,
      content: Text(
        isDenied
            ? AppString.locationPermissionDenied
            : AppString.locationPermissionDeniedForever,
        style: AppStyles.text12PxRegular,
        textAlign: TextAlign.center,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      actions: [
        CustomTextButton(
          text: isDenied ? AppString.ok : AppString.settings,
          onPressed: onPressed,
          textStyle: AppStyles.text12PxMedium,
        )
      ],
    );
  }
}
