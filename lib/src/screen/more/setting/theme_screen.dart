import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smc_flutter/src/src.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Theme',
        centerTitle: true,
      ),
      body: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.circular(
              Dimensions.radiusDefault,
            ),
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault,
            vertical: Dimensions.paddingSizeDefault,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault,
            vertical: Dimensions.paddingSizeDefault,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TitleActionChild(
                title: 'Theme Mode',
                titleStyle: AppStyles.text14PxMedium,
                titlePadding:
                    const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      themeProvider.darkTheme
                          ? 'Switching to Light Mode'
                          : 'Switching to Dark Mode',
                      style: AppStyles.text12PxRegular,
                    ),
                    Switch(
                      value: themeProvider.darkTheme,
                      onChanged: (value) {
                        themeProvider.toggleTheme();
                        onNavigate();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onNavigate() {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final currentTheme = themeProvider.darkTheme;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SwitchPreview(
          themeMode: currentTheme,
        );
      },
    );
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.pop(context);

        Utility.navigate(context, AppRoutes.dashboardScreen);
      },
    );
  }
}

class SwitchPreview extends StatelessWidget {
  final bool themeMode;
  const SwitchPreview({super.key, required this.themeMode});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) async {
        return Future.microtask(
          () => false,
        );
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                themeMode ? Icons.light_mode : Icons.dark_mode,
                size: 40.0,
              ),
              const SizedBox(height: 16.0),
              Text(
                themeMode
                    ? 'Switching to Dark Mode'
                    : 'Switching to Light Mode',
                style: AppStyles.text14PxMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
