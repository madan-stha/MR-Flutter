import 'package:flutter/material.dart';
import 'package:smc_flutter/src/src.dart';

class ContactSupportScreen extends StatelessWidget {
  const ContactSupportScreen({super.key});

  List<SettingModel> getSupportItems(String categoryName) {
    if (categoryName == 'Get in Touch') {
      return supportModel
          .where((item) => item.categoryName == categoryName)
          .toList();
    } else if (categoryName == 'Connect with Us') {
      return socialMediaModel
          .where((item) => item.categoryName == categoryName)
          .toList();
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Help & Support',
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategory('Get in Touch'),
            _buildCategory('Connect with Us'),
          ],
        ),
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
          horizontal: Dimensions.paddingSizeEight,
          vertical: Dimensions.paddingSizeEight,
        ),
        child: TitleActionChild(
          title: categoryName,
          titleStyle: AppStyles.text14PxMedium,
          titlePadding:
              const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: SvgHelper.fromSource(
                  path: items[index].icon!,
                  color: categoryName == 'Get in Touch'
                      ? Theme.of(context).primaryColor
                      : null,
                ),
                dense: true,
                title: Text(
                  items[index].label,
                  style: AppStyles.text12PxRegular,
                ),
                onTap: () {
                  if (items[index].subtitle == 'website') {
                    () {};
                  } else {
                    launchUniversalLink(
                      items[index].url,
                    );
                  }
                },
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
