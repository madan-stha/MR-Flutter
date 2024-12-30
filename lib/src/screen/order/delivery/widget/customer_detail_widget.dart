import 'package:flutter/material.dart';

import '../../../../src.dart';

class CustomerDetailWidget extends StatelessWidget {
  final DeliveryDetailModel data;
  const CustomerDetailWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
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
        title: 'Customer Information',
        titleStyle: AppStyles.text14PxMedium,
        titlePadding: const EdgeInsets.only(
          bottom: 16.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Utility.isAccessible(data.customer.name))
              ReusableWidget().commonTextRender(
                'Name',
                data.customer.name,
              ),
            if (Utility.isAccessible(data.customer.contact))
              Gaps.verticalGapOf(10.0),
            if (Utility.isAccessible(data.customer.contact))
              ReusableWidget().commonTextRender(
                'Phone No.',
                data.customer.contact,
                onTap: () => launchInBrowser('tel:${data.customer.contact}'),
              ),
            if (Utility.isAccessible(data.customer.address))
              Gaps.verticalGapOf(10.0),
            if (Utility.isAccessible(data.customer.address))
              ReusableWidget().commonTextRender(
                'Address',
                data.customer.address,
                style2: AppStyles.text12PxMedium.copyWith(
                  color: Utility.getStatusColor(
                    data.status,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}