import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../src.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({super.key});

  @override
  State<ChangeLanguageScreen> createState() => ChangeLanguageScreenState();
}

class ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  bool? value = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var selectedLocale = EasyLocalization.of(context)!.locale;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Language'.tr(),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
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
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: LanguageProvider.supportedLanguages.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () => _onLanguageTap(context, index),
              leading: Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                  color: AppColors.kPrimaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  LanguageProvider.supportedLanguages[index].flag,
                  style: AppStyles.text16PxMedium.copyWith(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              title: Text(
                LanguageProvider.supportedLanguages[index].name,
                style: AppStyles.text14PxRegular,
              ),
              trailing: selectedLocale ==
                      Locale(
                        LanguageProvider.supportedLanguages[index].languageCode,
                      )
                  ? const Icon(
                      Icons.check,
                      color: Colors.green,
                    )
                  : null,
            );
          },
        ),
      ),
    );
  }

  void _onLanguageTap(BuildContext context, int index) {
    context.setLocale(
      Locale(
        LanguageProvider.supportedLanguages[index].languageCode,
      ),
    );
    Utility.navigateMaterialRoute(
      context,
      const DashboardScreen(),
    );
  }
}
