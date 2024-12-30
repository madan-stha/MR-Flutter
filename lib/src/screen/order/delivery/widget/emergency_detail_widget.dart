import 'package:flutter/material.dart';

import '../../../../src.dart';

class EmergencyDetailWidget extends StatelessWidget {
  final DeliveryDetailModel data;

  const EmergencyDetailWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
  var emergency = data.emergencyContact;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(
          Dimensions.radiusDefault,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSizeDefault,
        vertical: Dimensions.paddingSizeEight,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSizeEight,
        vertical: Dimensions.paddingSizeExtraSmall,
      ),
      child: TitleActionChild(
        title: 'Emergency Contact',
        titleStyle: AppStyles.text14PxMedium,
        titlePadding: const EdgeInsets.only(
          bottom: 16.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Utility.isAccessible(emergency.name))
              ReusableWidget().commonTextRender(
                'Name',
                emergency.name,
              ),
            if (Utility.isAccessible(emergency.contact))
              Gaps.verticalGapOf(10.0),
            if (Utility.isAccessible(emergency.contact))
              ReusableWidget().commonTextRender(
                'Phone No.',
                emergency.contact,
                onTap: () => launchInBrowser('tel:${emergency.contact}'),
              ),
            if (Utility.isAccessible(emergency.message))
              Gaps.verticalGapOf(10.0),
            if (Utility.isAccessible(emergency.message))
              Text(
                emergency.message,
                textAlign: TextAlign.center,
                style: AppStyles.text12PxRegular.copyWith(
                  color: Utility.getStatusColor(
                    data.status,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }}