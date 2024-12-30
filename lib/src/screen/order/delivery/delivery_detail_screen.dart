import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:provider/provider.dart';
import 'package:smc_flutter/src/src.dart';

class DeliveryDetailScreen extends StatefulWidget {
  final data;
  const DeliveryDetailScreen({super.key, required this.data});

  @override
  State<DeliveryDetailScreen> createState() => _DeliveryDetailScreenState();
}

class _DeliveryDetailScreenState extends State<DeliveryDetailScreen> {
  List<LatLng> _driverLatLng = [];
  bool _isFetchingLocation = true; // Added to track fetching status

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    context.read<DeliveryDetailProvider>().fetchData(id: widget.data.id);
  }

  Future<void> getCurrentLocation() async {
    final currentLocation = await LocationUtility.getCurrentLocation();
    final driverCoordinates = widget.data.driverCoordinates;

    if (driverCoordinates != null && driverCoordinates.isNotEmpty) {
      setState(() {
        _driverLatLng.add(LatLng(
          double.parse(driverCoordinates[0].toString()),
          double.parse(driverCoordinates[1].toString()),
        ));
      });
    } else if (currentLocation != null) {
      setState(() {
        _driverLatLng.add(currentLocation);
      });
    } else {
      print("No location found.");
    }
    setState(() {
      _isFetchingLocation = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var name = widget.data.tripName.split('|');
    var name2 = name[1].replaceAll('-', '');
    var finalName = '${name[0]} - $name2';
    return Scaffold(
      appBar: CustomAppBar(
        title: finalName,
        centerTitle: true,
      ),
      body: Consumer<DeliveryDetailProvider>(
        builder: (context, state, _) {
          if (state.isLoading) {
            return Center(
              child: CustomLoader(
                child: CustomImage(
                  Assets.logo,
                  height: Dimensions.loaderSize,
                  width: Dimensions.loaderSize,
                  imageType: CustomImageType.local,
                ),
              ),
            );
          } else {
            var detailData = state.deliveryDetail;

            return !Utility.isAccessible(detailData)
                ? const NoDataFoundScreen()
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TripDetailWidget(data: detailData!, name: finalName),
                          if (Utility.isAccessible(detailData.items))
                            Gaps.verticalGapOf(10.0),
                          if (Utility.isAccessible(detailData.items))
                            materialInformation(detailData),
                          if (Utility.isAccessible(detailData.customer))
                            Gaps.verticalGapOf(10.0),
                          if (Utility.isAccessible(detailData.customer))
                            CustomerDetailWidget(data: detailData),
                          if (Utility.isAccessible(detailData.emergencyContact))
                            Gaps.verticalGapOf(10.0),
                          if (Utility.isAccessible(detailData.emergencyContact))
                            EmergencyDetailWidget(
                              data: detailData,
                            ),
                          if (detailData.status != "completed")
                            viewRoute(
                              onTap: () {
                                getCurrentLocation();
                                if (_isFetchingLocation) {
                                  CustomToast.show(
                                      'Fetching location, please wait...',
                                      isSuccess: true);
                                } else if (widget.data.status == 'pending' &&
                                    widget.data.driverCoordinates == null) {
                                  BottomModelSheet.showCustomModalBottomSheet(
                                    context: context,
                                    modal: MapsList(
                                      location: Coords(
                                        detailData.coordinate[0],
                                        detailData.coordinate[1],
                                      ),
                                      type: AppConstants.delivery,
                                      onMapSelected: (map) {
                                        final DateTime currentDate =
                                            DateTime.now();
                                        Map<String, dynamic> body = {
                                          "status":
                                              detailData.status == 'pending'
                                                  ? 'in_progress'
                                                  : 'completed',
                                          "started_at":
                                              DateUtility.formatDateTime(
                                                  currentDate),
                                          "driver_coordinates": [
                                            _driverLatLng.first.latitude
                                                .toString(),
                                            _driverLatLng.first.longitude
                                                .toString()
                                          ],
                                        };
                                        if (detailData.status == 'pending') {
                                          var updateProvider = context
                                              .read<DeliveryDetailProvider>();

                                          print('body---> $body');
                                          updateProvider.startTrip(
                                            context: context,
                                            id: detailData.id,
                                            startObj: body,
                                          );
                                        }
                                      },
                                      destinationTitle:
                                          detailData.customer.name,
                                      currentLocation: Coords(
                                        _driverLatLng.first.latitude,
                                        _driverLatLng.first.longitude,
                                      ),
                                      title:
                                          "${detailData.tripName} ⁃ ${detailData.customer.name}",
                                    ),
                                    isDarkMode: false,
                                  );
                                } else {
                                  Utility.navigateMaterialRoute(
                                    context,
                                    DeliveryUpdateScreen(
                                      data: detailData,
                                    ),
                                  );
                                }
                              },
                            ),
                        ],
                      ),
                    ),
                  );
          }
        },
      ),
      // bottomNavigationBar: viewRoute(
      //   onTap: () => Utility.navigateMaterialRoute(
      //     context,
      //     MapScreen(
      //       address: widget.data,
      //     ),
      //   ),
      // ),
    );
  }

  Widget materialInformation(DeliveryDetailModel data) {
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
        title: 'Material Information',
        titleStyle: AppStyles.text14PxMedium,
        titlePadding: const EdgeInsets.only(
          bottom: 16.0,
        ),
        child: DeliverMaterialTable(
          material: data.items,
        ),
      ),
    );
  }

  Widget viewRoute({onTap}) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 10.0,
      ),
      child: CustomMaterialButton(
        label: (widget.data.status == 'in_progress' &&
                widget.data.driverCoordinates != null)
            ? 'Mark As Completed'
            : 'Start Job',
        elevation: 0,
        onTap: onTap,
      ),
    );
  }
}
