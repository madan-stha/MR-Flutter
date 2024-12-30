import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smc_flutter/src/provider/verify_otp_provider.dart';
import 'package:smc_flutter/src/src.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String email;

  const VerifyOtpScreen({super.key, required this.email});

  @override
  _VerifyOtpScreenState createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  static final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Verify OTP',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 60),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Text(
                  'Enter the OTP sent to ${widget.email}',
                  style: AppStyles.text20PxMedium
                      .copyWith(color: const Color(0xFF506171)),
                ),
              ),
              CustomTextField(
                isRequired: true,
                controller: otpController,
                textInputAction: TextInputAction.done,
                prefix: SvgHelper.fromSource(
                    path: Assets.lock, height: 20, width: 20),
                onEditingComplete: () {
                  FocusScope.of(context).unfocus();
                },
                hintText: "OTP",
                labelText: "Enter your OTP",
              ),
              Gaps.verticalGapOf(30),
              CustomMaterialButton(
                onTap: () async {
                  await context.read<VerifyOtpProvider>().verifyOtp(
                        context,
                        otpController.text,
                        widget.email,
                      );
                },
                label: "Verify",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
