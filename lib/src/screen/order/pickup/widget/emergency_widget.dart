import 'package:flutter/material.dart';

import '../../../../src.dart';

class PEmergencyDetailWidget extends StatelessWidget {
  final Pickup data;

  const PEmergencyDetailWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var emergency = data.emergency;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Utility().horizonDivider(
          'Emergency Contact',
        ),
        Gaps.verticalGapOf(10.0),
        if (Utility.isAccessible(emergency.name))
          ReusableWidget().commonTextRender(
            'Name',
            emergency.name,
          ),
        if (Utility.isAccessible(emergency.contact)) Gaps.verticalGapOf(10.0),
        if (Utility.isAccessible(emergency.contact))
          ReusableWidget().commonTextRender(
            'Phone No.',
            emergency.contact,
            onTap: () => launchInBrowser('tel:${emergency.contact}'),
          ),
        if (Utility.isAccessible(emergency.extra)) Gaps.verticalGapOf(10.0),
        if (Utility.isAccessible(emergency.extra))
          Text(
            emergency.extra,
            textAlign: TextAlign.center,
            style: AppStyles.text12PxRegular.copyWith(
              color: Utility.getStatusColor(
                data.status,
              ),
            ),
          ),
      ],
    );
  }
}
