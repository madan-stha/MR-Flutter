import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:map_launcher/map_launcher.dart';
import 'package:smc_flutter/src/src.dart';

class PickupBottomSheetScreen extends StatefulWidget {
  final List<Pickup> pickups;
  final GoogleMapController? controller;
  const PickupBottomSheetScreen(
      {super.key, required this.pickups, this.controller});

  @override
  State<PickupBottomSheetScreen> createState() =>
      _PickupBottomSheetScreenState();
}

class _PickupBottomSheetScreenState extends State<PickupBottomSheetScreen> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 2 / 3,
        width: double.infinity,
        child: DraggableScrollableSheet(
          initialChildSize: 0.2,
          maxChildSize: 0.65,
          minChildSize: 0.16,
          snap: true,
          builder: (context, scrollController) => Container(
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(Dimensions.radiusDefault),
                topLeft: Radius.circular(Dimensions.radiusDefault),
              ),
              boxShadow: [
                BoxShadow(
                    color: AppColors.blackColor.withOpacity(0.15),
                    blurRadius: 5,
                    offset: const Offset(0, -1))
              ],
            ),
            child: ListView(
              controller: scrollController,
              padding: EdgeInsets.only(
                top: Dimensions.paddingSizeEight,
                bottom: MediaQuery.paddingOf(context).bottom +
                    Dimensions.paddingSizeDefault,
                left: Dimensions.paddingSizeDefault,
                right: Dimensions.paddingSizeDefault,
              ),
              children: [
                Container(
                  height: 5,
                  margin: EdgeInsets.symmetric(
                      horizontal: (MediaQuery.sizeOf(context).width - 100) / 2),
                  decoration: BoxDecoration(
                    color: AppColors.bottomSheetIconColor,
                    borderRadius: BorderRadius.circular(
                        Dimensions.radiusExtraMoreLarge - 10),
                  ),
                ),
                Gaps.verticalGapOf(
                  24.0,
                ),
                ..._buildBottomSheetContent(widget.pickups),
                Gaps.verticalGapOf(
                  30.0,
                ),
                CustomMaterialButton(
                  label: 'Start',
                  elevation: 0,
                  height: 40,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBottomSheetContent(List<Pickup> pickups) {
    List<Widget> timelineWidgets = [];

    pickups.asMap().forEach((index, pickup) {
      // Add customer name and notes to the timeline view
      timelineWidgets.addAll([
        timelineRow(
            pickup.customer.name,
            pickup.customer.phoneNumber,
            pickup.status,
            index == pickups.length - 1,
            pickup.coordinates,
            index),
      ]);
    });

    return timelineWidgets;
  }

  Widget timelineRow(String title, String subTile, String status, bool isLast,
      List<dynamic> coordinates, index) {
    return customInkwell(
      onTap: () {
        final pickupLocation = LatLng(coordinates[0], coordinates[1]);
        widget.controller!
            .animateCamera(CameraUpdate.newLatLngZoom(pickupLocation, 15));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 20,
                  height: 20,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Utility.getStatusColor(status),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      Utility.getIndexAlpha(
                        index,
                      ),
                      textAlign: TextAlign.center,
                      style: AppStyles.text10PxMedium,
                    ),
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 3,
                    height: MediaQuery.of(context).size.height * 0.07,
                    decoration: BoxDecoration(
                      color: Utility.getStatusColor(status),
                      shape: BoxShape.rectangle,
                    ),
                    child: const Text(
                      '',
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppStyles.text14PxMedium,
                    ),
                    Text(
                      Utility.isAccessible(subTile) ? subTile : 'N/A',
                      style: AppStyles.text12PxRegular,
                    ),
                  ],
                ),
                ReusableWidget().roundedIcon(
                  context,
                  icon: Icons.map_outlined,
                  onTap: () {
                    print("Map icon tapped"); // Debug print statement
                    // final pickupLocation = LatLng(
                    //   coordinates[0],
                    //   coordinates[1],
                    // );
                    // BottomModelSheet.showCustomModalBottomSheet(
                    //   context: context,
                    //   modal: MapsList(
                    //     location: Coords(
                    //       pickupLocation.latitude,
                    //       pickupLocation.longitude,
                    //     ),
                    //     title: "A",
                    //   ),
                    //   isDarkMode: false,
                    // );
                    print("Map icon tapped 2"); // Debug print statement
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
