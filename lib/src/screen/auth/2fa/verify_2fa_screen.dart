import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:smc_flutter/src/src.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  String _verificationCode = '';
  String _otp = '';
  String get otp => _otp;
  String get verificationCode => _verificationCode;
  var userProvider;
  @override
  void initState() {
    super.initState();
    userProvider = context.read<UserProvider>().user;
  }

  updateVerificationCode(String value) {
    _verificationCode = value;
    if (_verificationCode.isNotEmpty) {
      setState(
        () {
          _otp = _verificationCode;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppString.lblConfirmationCode,
        bgColor: AppColors.white,
        titleColor: AppColors.kPitchBlackColor,
        radius: false,
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(
            Dimensions.radiusDefault,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault,
          vertical: Dimensions.paddingSizeDefault,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.verticalGapOf(
              20.0,
            ),
            Text(
              AppString.msg2FAConfirmation,
              style: AppStyles.text14PxRegular,
              textAlign: TextAlign.center,
            ),
            Gaps.verticalGapOf(
              30.0,
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.15,
                child: PinCodeTextField(
                  length: AppConstants.maximunPinCodeLength,
                  appContext: context,
                  autoFocus: true,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.slide,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    fieldHeight: 46,
                    fieldWidth: 46,
                    borderWidth: 1,
                    borderRadius: BorderRadius.circular(
                      8.0,
                    ),
                    selectedColor: Theme.of(context).primaryColor,
                    selectedFillColor: AppColors.greySecondary.withOpacity(0.5),
                    inactiveFillColor:
                        Theme.of(context).primaryColor.withOpacity(0.1),
                    inactiveColor: Theme.of(context).primaryColorLight,
                    activeColor:
                        Theme.of(context).primaryColor.withOpacity(0.2),
                    activeFillColor: Theme.of(context).cardColor,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  onChanged: updateVerificationCode,
                  beforeTextPaste: (text) => true,
                ),
              ),
            ),
            const Spacer(),
            CustomMaterialButton(
              label: AppString.lblSubmit,
              elevation: 0,
              onTap: () {
                print("userProvider---> ${userProvider.id}");

                var requestBody = {
                  "user": userProvider.id,
                  "otp": _otp,
                };
                context.read<TwoFaProvider>().validate2FA(context, requestBody);
              },
            ),
          ],
        ),
      ),
    );
  }
}
