import 'package:flutter/material.dart';
import 'package:smc_flutter/src/src.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppString.about,
      ),
    );
  }
}
