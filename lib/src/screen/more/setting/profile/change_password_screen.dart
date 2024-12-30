import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smc_flutter/src/src.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool _obscureText = true;
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var authState;

  @override
  void initState() {
    super.initState();
    authState = context.read<AuthProvider>();
  }

  @override
  void dispose() {
    super.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Change Password',
        centerTitle: true,
        isBackButtonExist: true,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(
              Dimensions.radiusDefault,
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault,
            vertical: Dimensions.paddingSizeEight,
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeEight,
            vertical: Dimensions.paddingSizeExtraSmall,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TitleActionChild(
                title: AppString.lblEnterCurrentPassword,
                titlePadding: const EdgeInsets.only(
                  bottom: 10.0,
                ),
                titleStyle: AppStyles.text14PxMedium,
                child: CustomTextField2(
                  hintText: AppString.lblCurrentPassword,
                  isPasswordField: _obscureText,
                  controller: _currentPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  validation: (value) {
                    return Validator.validatePassword(value!);
                  },
                  textInputAction: TextInputAction.done,
                  prefixIcon: Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: SvgHelper.fromSource(
                        path: Assets.lock, height: 20, width: 20),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(
                        () {
                          _obscureText = !_obscureText;
                        },
                      );
                    },
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                ),
              ),
              Gaps.verticalGapOf(
                16.0,
              ),
              TitleActionChild(
                title: AppString.lblEnterNewPassword,
                titlePadding: const EdgeInsets.only(
                  bottom: 10.0,
                ),
                titleStyle: AppStyles.text14PxMedium,
                child: CustomTextField2(
                  hintText: AppString.lblNewPassword,
                  isPasswordField: _obscureText,
                  controller: _newPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  validation: (value) {
                    if (_newPasswordController.text.isEmpty) {
                      return AppString.lblEnterNewPassword;
                    } else if (_currentPasswordController.text ==
                        _newPasswordController.text) {
                      return AppString
                          .msgNewPasswordShouldNotBeSameAsCurrentPassword;
                    } else {
                      return Validator.validatePassword(value!);
                    }
                  },
                  textInputAction: TextInputAction.done,
                  prefixIcon: Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: SvgHelper.fromSource(
                        path: Assets.lock, height: 20, width: 20),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(
                        () {
                          _obscureText = !_obscureText;
                        },
                      );
                    },
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                ),
              ),
              Gaps.verticalGapOf(
                16.0,
              ),
              TitleActionChild(
                title: AppString.lblEnterConfirmPassword,
                titlePadding: const EdgeInsets.only(
                  bottom: 10.0,
                ),
                titleStyle: AppStyles.text14PxMedium,
                child: CustomTextField2(
                  hintText: AppString.lblConfirmNewPassword,
                  isPasswordField: _obscureText,
                  controller: _confirmPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  validation: (value) {
                    if (_confirmPasswordController.text.isEmpty) {
                      return AppString.lblEnterConfirmPassword;
                    }
                    if (_newPasswordController.text !=
                        _confirmPasswordController.text) {
                      return AppString.msgPasswordDoesNotMatch;
                    } else if (_currentPasswordController.text ==
                        _confirmPasswordController.text) {
                      return AppString
                          .msgNewPasswordShouldNotBeSameAsCurrentPassword;
                    } else {
                      return Validator.validatePassword(value!);
                    }
                  },
                  textInputAction: TextInputAction.done,
                  prefixIcon: Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: SvgHelper.fromSource(
                        path: Assets.lock, height: 20, width: 20),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(
                        () {
                          _obscureText = !_obscureText;
                        },
                      );
                    },
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                ),
              ),
              Gaps.verticalGapOf(
                30,
              ),
              CustomMaterialButton(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    authState.changePassword(
                        context,
                        _currentPasswordController.text,
                        _newPasswordController.text,
                        _confirmPasswordController.text);
                  }
                },
                elevation: 0,
                label: "Change Password",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
