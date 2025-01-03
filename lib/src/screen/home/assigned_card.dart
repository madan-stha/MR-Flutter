import 'package:flutter/material.dart';
import 'package:smc_flutter/src/src.dart';

class AssignedCard extends StatelessWidget {
  final DashboardModel data;
  const AssignedCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    bool pickup = data.type == AppConstants.pickup;
    var name = pickup ? data.name.split('|') : data.tripName.split('|');
    var name2 =
        pickup ? name[1].replaceAll('-', '') : name[1].replaceAll('-', '');
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              finalName,
              style: AppStyles.text14PxMedium,
            ),
            Text(
              DateUtility.getFormattedDate(
                  pickup ? data.startDate : data.tripDate),
              style: AppStyles.text10PxRegular,
            ),
            Gaps.verticalGapOf(
              10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReusableWidget().iconValue(
                    isIconContainer: false,
                    icon: Utility.getStatusIcon(data.type),
                    iconType: "icon",
                    size: 16.0,
                    title: Utility.getStatus(data.type)),
                Gaps.horizontalGapOf(
                  10.0,
                ),
                ReusableWidget().iconValue(
                  isIconContainer: false,
                  icon: Assets.materials,
                  size: 16.0,
                  title: Utility.formatCustomerNames(data.materialsLoaded),
                ),
              ],
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
                      data.type == AppConstants.pickup
                          ? OrderDetailScreen(
                              data: data,
                            )
                          : DeliveryDetailScreen(
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
