import 'package:flutter/material.dart';

import '../../../../src.dart';

class TripDetailWidget extends StatelessWidget {
  final DeliveryDetailModel data;
  final String name;
  const TripDetailWidget({super.key, required this.data, required this.name});

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
        title: 'Trip Information',
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
              name,
            ),
            Gaps.verticalGapOf(10.0),
            ReusableWidget().commonTextRender(
              'Trip No.',
              "${data.tripNumber}",
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
              'Trip Date',
              DateUtility.extractDate(
                data.tripDate,
              ),
            ),
            Gaps.verticalGapOf(10.0),
            if (data.startedAt != null || data.startedAt != "")
              ReusableWidget().commonTextRender(
                'Start Date',
                Utility.isAccessible(data.startedAt)
                    ? DateUtility.formatedDateTime(
                        data.startedAt,
                      )
                    : 'N/A',
              ),
            if (data.startedAt != null) Gaps.verticalGapOf(10.0),
            if (data.endedAt != null || data.endedAt != "")
              ReusableWidget().commonTextRender(
                'End Date',
                Utility.isAccessible(data.endedAt)
                    ? DateUtility.formatedDateTime(
                        data.endedAt,
                      )
                    : 'N/A',
              ),
            if (data.endedAt != null) Gaps.verticalGapOf(10.0),
            ReusableWidget().commonTextRender(
              'Weight',
              "${data.weightOfMaterials} Tons",
            ),
          ],
        ),
      ),
    );
  }
}
