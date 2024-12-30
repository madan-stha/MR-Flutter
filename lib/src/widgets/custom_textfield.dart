import 'package:flutter/material.dart';
import 'package:smc_flutter/src/src.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final String? labelText; 
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Widget? prefix;
  final Widget? suffix;
  final bool isObsecure;
  final bool isRequired;
  final bool isContentPading;
  final int? maxlines;
  final bool isOtherform;
  final bool tofill;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;

  const CustomTextField({
    super.key,
    this.maxlines,
    this.hintText,
    this.labelText, // Changed this line
    this.suffix,
    this.prefix,
    this.controller,
    this.validator,
    this.isContentPading = false,
    this.isRequired = false,
    this.isObsecure = false,
    this.isOtherform = false,
    this.tofill = false,
    this.textInputAction = TextInputAction.done,
    this.onEditingComplete,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.labelText!,
              style: AppStyles.text12PxMedium
                  .copyWith(color: const Color(0xFF434343)),
            ),
          ),
        Focus(
          onFocusChange: (hasFocus) {
            setState(() {
              _isFocused = hasFocus;
            });
          },
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onEditingComplete: widget.onEditingComplete ?? () {},
            style: AppStyles.text14PxRegular,
            maxLines: widget.maxlines ?? 1,
            validator: (value) {
              if (value!.isEmpty && widget.isRequired) {
                return "Field cannot be empty";
              }
              if (widget.validator != null) {
                return widget.validator!(value);
              }
              return null;
            },
            textInputAction: widget.textInputAction,
            controller: widget.controller,
            obscureText: widget.isObsecure,
            decoration: InputDecoration(
              contentPadding: widget.isContentPading
                  ? null
                  : const EdgeInsets.symmetric(vertical: 18.0),
              isDense: true,
              fillColor: widget.tofill
                  ? AppColors.kPrimaryColor.withOpacity(0.04)
                  : Colors.transparent,
              filled: true,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 3),
                child: widget.prefix,
              ),
              prefixIconConstraints:
                  const BoxConstraints(minWidth: 45, minHeight: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(
                  color: _isFocused
                      ? Theme.of(context).primaryColor
                      : AppColors.greyColor,
                  width: 1, // Adjust border thickness here
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Colors.red),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(
                  color: widget.isOtherform
                      ? AppColors.kPrimaryColor
                      : AppColors.greyColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2, // Adjust border thickness here
                ),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: widget.suffix,
              ),
              suffixIconConstraints:
                  const BoxConstraints(minWidth: 0, minHeight: 0),
              hintStyle: AppStyles.text12PxRegular
                  .copyWith(color: const Color(0xFF434343)),
              errorStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
              hintText: widget.hintText,
            ),
          ),
        ),
      ],
    );
  }
}
