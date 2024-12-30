import 'package:flutter/material.dart';

import '../src.dart';

class CustomTextField2 extends StatelessWidget {
  final String hintText;
  final Function(String)? onChanged;
  final String? Function(String?)? validation;
  final TextInputAction textInputAction;
  final TextInputType? keyboardType;
  final bool isPasswordField;
  final FocusNode? focusNode;
  final bool isNumberField;
  final String? icon;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool contentPadding;
  final double? paddingHorizontal;
  final double? paddingVertical;
  final double marginBottom;
  final double borderRadius;
  final TextEditingController? controller;
  final int? maxLines;
  final int? minLines;
  final bool? isReadOnly;
  final bool? onlyline;

  final VoidCallback? onEditingComplete;

  const CustomTextField2({
    super.key,
    required this.hintText,
    this.onChanged,
    this.textInputAction = TextInputAction.next,
    this.keyboardType,
    this.isPasswordField = false,
    this.focusNode,
    this.isNumberField = false,
    this.controller,
    this.validation,
    this.icon,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding = true,
    this.paddingHorizontal,
    this.marginBottom = 19,
    this.borderRadius = 8,
    this.paddingVertical,
    this.maxLines,
    this.isReadOnly = false,
    this.minLines,
    this.onEditingComplete,
    this.onlyline = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType ??
          (isNumberField ? TextInputType.number : TextInputType.text),
      focusNode: focusNode,
      onChanged: onChanged,
      readOnly: isReadOnly!,
      maxLines: maxLines ?? 1,
      minLines: minLines,
      validator: validation,
      onEditingComplete: onEditingComplete,
      autofillHints: keyboardType == TextInputType.name
          ? [AutofillHints.name]
          : keyboardType == TextInputType.emailAddress
              ? [AutofillHints.email]
              : keyboardType == TextInputType.phone
                  ? [AutofillHints.telephoneNumber]
                  : keyboardType == TextInputType.streetAddress
                      ? [AutofillHints.fullStreetAddress]
                      : keyboardType == TextInputType.url
                          ? [AutofillHints.url]
                          : keyboardType == TextInputType.visiblePassword
                              ? [AutofillHints.password]
                              : null,
      autofocus: false,
      textInputAction: textInputAction,
      obscureText: isPasswordField,
      obscuringCharacter: '*',
      style: AppStyles.text14PxRegular,
      decoration: onlyline == false
          ? InputDecoration(
              fillColor: AppColors.greySecondary.withOpacity(0.5),
              filled: true,
              isDense: true,
              errorStyle: AppStyles.text12PxRegular
                  .copyWith(color: AppColors.rejectedColor),
              prefixIcon: prefixIcon ??
                  (icon != null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 22.0,
                              width: 40.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(icon!),
                                    fit: BoxFit.fitHeight),
                              ),
                            ),
                          ],
                        )
                      : null),
              suffixIcon: suffixIcon,
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(borderRadius)),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.kPrimaryColor)),
              errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.warningColor)),
              focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.kPrimaryColor)),
              hintText: hintText,
              contentPadding: contentPadding
                  ? EdgeInsets.symmetric(
                      horizontal: paddingHorizontal ?? 0,
                      vertical: paddingVertical ?? 0) //14
                  : const EdgeInsets.all(12.0),
            )
          : InputDecoration(
              fillColor: AppColors.greySecondary.withOpacity(0.5),
              // filled: true,
              isDense: true,
              errorStyle: AppStyles.text12PxRegular
                  .copyWith(color: AppColors.rejectedColor),
              prefixIcon: prefixIcon ??
                  (icon != null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 22.0,
                              width: 40.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(icon!),
                                    fit: BoxFit.fitHeight),
                              ),
                            ),
                          ],
                        )
                      : null),
              suffixIcon: suffixIcon,
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.kPrimaryColor),
              ),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.warningColor),
              ),
              focusedErrorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.kPrimaryColor),
              ),
              hintText: hintText,
              contentPadding: contentPadding
                  ? EdgeInsets.symmetric(
                      horizontal: paddingHorizontal ?? 0,
                      vertical: paddingVertical ?? 14)
                  : const EdgeInsets.all(12.0),
            ),
    );
  }
}
