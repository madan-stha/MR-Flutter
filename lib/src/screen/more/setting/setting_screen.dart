import 'package:flutter/material.dart';
import 'package:smc_flutter/src/src.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Settings',
        centerTitle: true,
        isBackButtonExist: true,
      ),
      body: SettingsCard(),
    );
  }
}

class SettingsCard extends StatelessWidget {
  const SettingsCard({super.key});

  List<SettingModel> getSupportItems(String categoryName) {
    if (categoryName == 'Personal Profile Setting') {
      return settingsItems
          .where((item) => item.categoryName == categoryName)
          .toList();
    } else if (categoryName == 'Notification Preference') {
      return settingsItems
          .where((item) => item.categoryName == categoryName)
          .toList();
    } else if (categoryName == 'Help & Support') {
      return settingsItems
          .where((item) => item.categoryName == categoryName)
          .toList();
    } else if (categoryName == 'Language Preference') {
      return settingsItems
          .where((item) => item.categoryName == categoryName)
          .toList();
    } else if (categoryName == 'Others') {
      return settingsItems
          .where((item) => item.categoryName == categoryName)
          .toList();
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategory('Personal Profile Setting'),
          _buildCategory('Notification Preference'),
          _buildCategory('Help & Support'),
          _buildCategory('Language Preference'),
          _buildCategory('Others'),
        ],
      ),
    );
  }

  Widget _buildCategory(String categoryName) {
    List<SettingModel> items = getSupportItems(categoryName);
    if (items.isNotEmpty) {
      return Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(
            Dimensions.radiusDefault,
          ),
        ),
        margin: const EdgeInsets.only(
          bottom: Dimensions.paddingSizeDefault,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault,
          vertical: Dimensions.paddingSizeDefault,
        ),
        child: TitleActionChild(
          title: categoryName,
          titleStyle: AppStyles.text14PxMedium,
          titlePadding: const EdgeInsets.only(
            bottom: Dimensions.paddingSizeSmall,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return customInkwell(
                onTap: () {
                  Utility.navigate(
                    context,
                    items[index].url,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        items[index].label,
                        style: AppStyles.text12PxRegular,
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
