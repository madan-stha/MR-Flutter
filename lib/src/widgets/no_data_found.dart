import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../src.dart';

class NoDataFoundScreen extends StatelessWidget {
  final bool isShowHome;
  final String? title;
  final String? description;
  const NoDataFoundScreen(
      {super.key, this.isShowHome = false, this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.paddingSizeExtraMoreLarge),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: SvgHelper.fromSource(
              path: Assets.noData,
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.height * 0.2,
              type: SvgSourceType.asset,
            ),
          ),
          Text(
            title ?? 'no_data_found'.tr(),
            style: AppStyles.text18PxMedium,
            textAlign: TextAlign.center,
          ),
          Gaps.verticalGapOf(MediaQuery.of(context).size.height * 0.01),
          Text(
            description ?? 'no_data_found_des'.tr(),
            style: AppStyles.text14PxRegular,
            textAlign: TextAlign.center,
          ),
          Gaps.verticalGapOf(MediaQuery.of(context).size.height * 0.06),
          if (isShowHome)
            CustomMaterialButton(
              height: 40,
              width: 200,
              label: 'back_to_homepage'.tr(),
              onTap: () => Utility.navigate(context, AppRoutes.dashboardScreen),
            ),
        ],
      ),
    );
  }
}
