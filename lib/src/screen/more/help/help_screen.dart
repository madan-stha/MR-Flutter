import 'package:flutter/material.dart';
import 'package:smc_flutter/src/src.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppString.help,
      ),
    );
  }
}
