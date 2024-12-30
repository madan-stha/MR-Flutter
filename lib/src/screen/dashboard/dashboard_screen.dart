import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smc_flutter/src/src.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final SharedPreferencesService _sharedPref = SharedPreferencesService();
  bool isDriver = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRole();
  }

  fetchRole() async {
    var data = await _sharedPref.getStringPref('userData');
    var driver = data['role'] == 'driver';
    setState(() {
      isDriver = driver;
    });

    // Simulate a 3-second loading delay
    Timer(
      const Duration(seconds: 1),
      () {
        setState(
          () {
            isLoading = false;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print('isDriver $isDriver');
    print('timer $isLoading');
    return isLoading
        ? Scaffold(
            body: Center(
              child: CustomLoader(
                child: CustomImage(
                  Assets.logo,
                  height: Dimensions.loaderSize,
                  width: Dimensions.loaderSize,
                  imageType: CustomImageType.local,
                ),
              ),
            ),
          )
        : !isDriver
            ? const CustomerDashboardScreen()
            : const DriverDashboardScreen();
  }
}
