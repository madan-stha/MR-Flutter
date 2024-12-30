import 'package:flutter/material.dart';

import '../../../../src.dart';

class PickupDetailWidget extends StatelessWidget {
  final data;
  final finalName;
  const PickupDetailWidget(
      {super.key, required this.data, required this.finalName});

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
        title: 'Route Information',
        titleStyle: AppStyles.text14PxMedium,
        titlePadding: const EdgeInsets.only(
          bottom: 16.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReusableWidget().commonTextRender(
              'Name',
              finalName,
            ),
            Gaps.verticalGapOf(10.0),
            ReusableWidget().commonTextRender(
              'Description',
              data.description,
            ),
            Gaps.verticalGapOf(10.0),
            ReusableWidget().commonTextRender(
              'Status',
              Utility.getStatus(
                data.status,
              ),
              style2: AppStyles.text12PxMedium.copyWith(
                color: Utility.getStatusColor(
                  data.status,
                ),
              ),
            ),
            Gaps.verticalGapOf(10.0),
            ReusableWidget().commonTextRender(
              'Pickup Date',
              DateUtility.extractDate(
                data.startDate,
              ),
            ),
            Gaps.verticalGapOf(10.0),
            // ReusableWidget().commonTextRender(
            //   'Customer',
            //   Utility.formatCustomerNames(
            //     data.customers,
            //   ),
            // ),
            // Gaps.verticalGapOf(10.0),
            // ReusableWidget().commonTextRender(
            //   'Total Amount',
            //   "Rs. ${data.amount.join(',')}",
            // ),
          ],
        ),
      ),
    );
  }
}
