import 'package:flutter/material.dart';

import '../../../src.dart';

class PickupCard extends StatelessWidget {
  final PickUpRoutesModel data;
  final String currentAddress;
  const PickupCard(
      {super.key, required this.data, required this.currentAddress});

  @override
  Widget build(BuildContext context) {
    var name = data.name.split('|');
    var name2 = name[1].toString().replaceAll('-', '');

    var finalName = "${name[0]} - $name2";
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
              DateUtility.extractDate(
                data.startDate,
              ),
              style: AppStyles.text10PxRegular,
            ),
            Gaps.verticalGapOf(
              10.0,
            ),
            ...data.customers.map(
              (e) => ListTile(
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
                      e.name,
                      style: AppStyles.text12PxMedium,
                    ),
                    // if ther is one customner, then show the address of coordinates one otherwise hide it
                    if (data.customers.length == 1)
                      Text(
                        currentAddress,
                        style: AppStyles.text10PxRegular,
                      ),
                  ],
                ),
                subtitle: Text(
                  e.contact,
                  style: AppStyles.text10PxRegular,
                ),
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
                      OrderDetailScreen(
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
