import 'package:flutter/material.dart';

import '../../src.dart';

class HomeCard extends StatefulWidget {
  final DashboardModel data;
  const HomeCard({
    super.key,
    required this.data,
  });

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  String? userCurrentAddress;

  @override
  void initState() {
    super.initState();
    fetchCurrentAddress();
  }

  void fetchCurrentAddress() async {
    try {
      // Fetch the current address
      var data = await LocationUtility.getCurrentAddress();
      setState(() {
        userCurrentAddress = data;
      });
    } catch (e) {
      print('Error fetching current address: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool pickup = widget.data.type == AppConstants.pickup;
    var name =
        pickup ? widget.data.name.split('|') : widget.data.tripName.split('|');
    var name2 =
        pickup ? name[1].replaceAll('-', '') : name[1].replaceAll('-', '');
    var finalName = '${name[0]} - $name2';

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(
          Dimensions.radiusDefault,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 0),
          )
        ],
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSizeSmall,
        vertical: Dimensions.paddingSizeEight,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          Dimensions.radiusDefault,
        ),
        child: customInkwell(
          onTap: () {
            Utility.navigateMaterialRoute(
              context,
              widget.data.type == AppConstants.pickup
                  ? OrderDetailScreen(
                      data: widget.data,
                    )
                  : DeliveryDetailScreen(
                      data: widget.data,
                    ),
            );
          },
          child: Stack(
            children: [
              // Image
              Image.asset(
                Assets.map,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              // Gradient
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.white,
                      AppColors.white,
                      AppColors.white.withOpacity(0.2),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                width: double.infinity,
                height: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeSmall,
                  vertical: Dimensions.paddingSizeSmall,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   'Current Tracking',
                    //   style: AppStyles.text12PxRegular,
                    // ),
                    // Gaps.verticalGapOf(10.0),
                    Text(
                      finalName,
                      style: AppStyles.text16PxMedium,
                    ),
                    Gaps.verticalGapOf(10.0),
                    ReusableWidget().iconValueColumn(
                      title: 'Current Location',
                      iconColor: Utility.getStatusColor(widget.data.status),
                      value: userCurrentAddress ?? 'Fetching...',
                    ),
                    Gaps.verticalGapOf(10.0),
                    ReusableWidget().iconValueColumn(
                      title: 'Status',
                      icon: Utility.getStatusIcon(widget.data.status),
                      iconColor: Utility.getStatusColor(widget.data.status),
                      value: Utility.getStatus(
                        widget.data.status,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
