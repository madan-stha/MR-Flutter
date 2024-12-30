import 'package:flutter/material.dart';

import '../../src.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel data;
  const NotificationCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSizeDefault,
        vertical: Dimensions.paddingSizeEight,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSizeEight,
        vertical: Dimensions.paddingSizeExtraSmall,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(
          Dimensions.radiusDefault,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Container(
              height: double.infinity,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  Dimensions.radiusDefault,
                ),
              ),
              child: Icon(
                Utility.getStatusIcon(
                  data.status,
                ),
                size: 30,
                color: Utility.getStatusColor(
                  data.status,
                ),
              ),
            ),
            title: Text(
              data.title,
              style: AppStyles.text14PxMedium,
            ),
            dense: true,
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  data.description,
                  style: AppStyles.text10PxRegular,
                ),
                Gaps.verticalGapOf(10),
                Text(
                  '${data.createdBy.split(' ')[0]} • ${DateUtility.extractDate(data.createdAt)}',
                  style: AppStyles.text10PxRegular,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
