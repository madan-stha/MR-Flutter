import 'package:flutter/material.dart';

import '../../src.dart';

class CustomerDashboardScreen extends StatefulWidget {
  const CustomerDashboardScreen({super.key});

  @override
  State<CustomerDashboardScreen> createState() =>
      _CustomerDashboardScreenState();
}

class _CustomerDashboardScreenState extends State<CustomerDashboardScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const CustomWebView(
      url: AppConstants.customerUrl,
      title: 'Dashboard',
      isLogout: true,
    );
  }
}
