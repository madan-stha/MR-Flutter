import 'package:flutter/material.dart';
import 'package:smc_flutter/src/src.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DialogManager.confirmationDialog(
      context,
      icon: Assets.sadLogout,
      title: AppString.logoutTitle,
      description: AppString.sureLogout,
      isLogOut: true,
      onYesPressed: () {
        Utility.logout();
      },
    );
  }
}
