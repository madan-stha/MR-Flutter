import 'package:flutter/material.dart';

import '../../../src.dart';

class DeliveryCard extends StatelessWidget {
  final DeliveryModel data;
  final String? currentAddress;
  const DeliveryCard({super.key, required this.data, this.currentAddress});

  @override
  Widget build(BuildContext context) {
    var name = data.tripName.split('|');
    var name2 = name[1].replaceAll('-', '');
    var finalName = '${name[0]} - $name2';
    return Card(
      elevation: 1.0,
      surfaceTintColor: Theme.of(context).canvasColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          Dimensions.radiusDefault,
        ),
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSizeDefault,
        vertical: Dimensions.paddingSizeEight,
      ),
      shadowColor: AppColors.kPrimaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeEight,
          vertical: Dimensions.paddingSizeEight,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              finalName,
              style: AppStyles.text14PxMedium,
            ),
            Text(
              DateUtility.extractDate(data.createdAt),
              style: AppStyles.text10PxRegular,
            ),
            Gaps.verticalGapOf(
              10.0,
            ),
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    Dimensions.radiusDefault,
                  ),
                  color: AppColors.kPrimaryColor.withOpacity(0.1),
                ),
                child: const Icon(
                  Icons.people_outlined,
                  color: AppColors.kPrimaryColor,
                  size: 22,
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.customer.name,
                    style: AppStyles.text12PxMedium,
                  ),
                  // if ther is one customner, then show the address of coordinates one otherwise hide it

                  Text(
                    currentAddress ?? "Please wait...",
                    style: AppStyles.text10PxRegular,
                  ),
                ],
              ),
              subtitle: Text(
                data.customer.contact,
                style: AppStyles.text10PxRegular,
              ),
            ),
            Gaps.verticalGapOf(
              20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomRoundedBox(
                  title: Utility.getStatus(
                    data.status,
                  ),
                  icon: Utility.getStatusIcon(
                    data.status,
                  ),
                  color: Utility.getStatusColor(
                    data.status,
                  ),
                ),
                customInkwell(
                  onTap: () {
                    Utility.navigateMaterialRoute(
                      context,
                      DeliveryDetailScreen(
                        data: data,
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.kPrimaryColor.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.trending_flat_outlined,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
