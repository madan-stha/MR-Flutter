import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:provider/provider.dart';

import '../../../src.dart';

class OrderDetailScreen extends StatefulWidget {
  final data;

  const OrderDetailScreen({
    super.key,
    required this.data,
  });

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final ScrollController scrollController = ScrollController();
  String currentAddress = '';
  List isCustomerExpandedList = [];
  final List<LatLng> _driverLatLng = [];
  bool _isFetchingLocation = true;
  var selectedRouteStatus = 'active';

  @override
  void initState() {
    super.initState();
    fetchData();
    context.read<ProutesDetailProvider>().fetchData(id: widget.data.id);
  }

  Future<void> getCurrentLocation() async {
    final currentLocation = await LocationUtility.getCurrentLocation();
    final driverCoordinates = widget.data.driverCoordinates;

    if (driverCoordinates != null && driverCoordinates.isNotEmpty) {
      setState(() {
        _driverLatLng.add(LatLng(driverCoordinates[0], driverCoordinates[1]));
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
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    try {
      var currentData = LocationUtility.getCurrentAddress();
      print('currentData--> $currentData');
      final address = await LocationUtility.getAddress(
        double.parse("27.6824437"),
        double.parse("85.3336026"),
      );
      currentAddress = address;

      setState(() {}); // Trigger a rebuild with updated addresses
    } catch (e) {
      // Handle errors
    }
  }

  @override
  Widget build(BuildContext context) {
    var name = widget.data.name.split('|');
    var name2 = name[1].toString().replaceAll('-', '');
    var finalName = "${name[0]} - $name2";
    return Scaffold(
      appBar: CustomAppBar(
        title: finalName,
        centerTitle: true,
      ),
      body: Consumer<ProutesDetailProvider>(
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
            return !Utility.isAccessible(state.pickUpRoutesDetail)
                ? const NoDataFoundScreen()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        PickupDetailWidget(
                          data: widget.data,
                          finalName: finalName,
                        ),
                        // if ((widget.data.status == 'active' &&
                        //         widget.data.driverCoordinates != null) ||
                        //     widget.data.status == 'pending')
                        Gaps.verticalGapOf(10.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeDefault,
                            vertical: Dimensions.paddingSizeEight,
                          ),
                          child: CustomMaterialButton(
                            label: widget.data.status == 'pending'
                                ? 'Start Route'
                                : 'Update Route',
                            onTap: () {
                              if (widget.data.status == 'pending') {
                                // Start the route
                                startRouteForPendingPickups(state);
                              } else {
                                // Update the route status and start the route
                                updateAndStartRoute(state);
                              }
                            },
                            elevation: 0,
                          ),
                        ),
                        Gaps.verticalGapOf(10.0),
                        customerTitle(),
                        ListView.builder(
                          itemCount: state.pickUpRoutesDetail.pickups.length,
                          shrinkWrap: true,
                          controller: scrollController,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var data = state.pickUpRoutesDetail.pickups[index];
                            while (isCustomerExpandedList.length <= index) {
                              isCustomerExpandedList.add(false);
                            }
                            print('widget.data.id--> ${widget.data.id}');
                            return SingleChildScrollView(
                              child: customerInformation(
                                  data, index, widget.data.id),
                            );
                          },
                        ),
                        Gaps.verticalGapOf(10.0),
                        // for (int i = 0; i < 1; i++)
                        //   PEmergencyDetailWidget(
                        //     data: state.pickUpRoutesDetail.pickups[i],
                        //   ),
                      ],
                    ),
                  );
          }
        },
      ),
    );
  }

  void startRouteForPendingPickups(ProutesDetailProvider state) {
    var provider = context.read<ProutesDetailProvider>();

    // Check if any pickup is pending
    bool anyPending = state.pickUpRoutesDetail.pickups
        .any((pickup) => pickup.status == 'pending');

    // If any pickup is pending, update route status and start route for pending pickups
    if (!anyPending) {
      print('---- Starting pending pickups route');
      provider.updateRouteStatus(
        context,
        AppConstants.active,
        widget.data.id,
      );
    }
    for (int i = 0; i < state.pickUpRoutesDetail.pickups.length; i++) {
      if (state.pickUpRoutesDetail.pickups[i].status == 'pending') {
        startRoute(state.pickUpRoutesDetail.pickups[i]);
      }
    }
  }

  void updateAndStartRoute(ProutesDetailProvider state) {
    var provider = context.read<ProutesDetailProvider>();

    print('---- Updating and starting route');

    // Check if any pickup is pending
    bool anyPending = state.pickUpRoutesDetail.pickups
        .any((pickup) => pickup.status == 'pending');

    // Check if any pickup is active
    bool anyActive = state.pickUpRoutesDetail.pickups
        .any((pickup) => pickup.status == 'active');

    // If there are active pickups, show message and return
    if (anyActive) {
      CustomToast.show('Complete the current task first.', isSuccess: false);
      return;
    }

    if (!anyPending) {
      // If no pending pickups, update route status
      provider.updateRouteStatus(
        context,
        widget.data.status == 'pending' ? 'active' : 'done',
        widget.data.id,
      );

      print('---- Route status updated');

      print('---- Route status updated');
    }

    // Start route for any pending pickups
    for (int i = 0; i < state.pickUpRoutesDetail.pickups.length; i++) {
      if (state.pickUpRoutesDetail.pickups[i].status == 'pending') {
        // Update only one pending pickup at a time
        startRoute(state.pickUpRoutesDetail.pickups[i]);
        break; // Stop after updating one pending pickup
      }
    }
  }

  // Method to handle starting the route
  void startRoute(Pickup data) {
    if (data.status == 'pending' && widget.data.driverCoordinates == null) {
      getCurrentLocation();

      if (_isFetchingLocation) {
        CustomToast.show('Fetching location, please wait...', isSuccess: true);
      } else {
        // If the order is pending and there are no driver coordinates, show the map for route selection
        BottomModelSheet.showCustomModalBottomSheet(
          context: context,
          modal: MapsList(
            location: Coords(
              data.coordinates[0],
              data.coordinates[1],
            ),
            type: AppConstants.pickup,
            onMapSelected: (map) {
              var provider = context.read<ProutesDetailProvider>();
              var currentDate = DateTime.now();
              var driverCoordinatesWithIndex = _driverLatLng
                  .asMap()
                  .map((key, value) => MapEntry(key.toString(), value));
              if (data.status == 'pending') {
                Map<String, dynamic> updateData = {
                  'status': data.status == 'pending' ? 'active' : 'active',
                  "started_at": DateUtility.formatDateTime(currentDate),
                  if (driverCoordinatesWithIndex.isNotEmpty) ...{
                    for (var entry in driverCoordinatesWithIndex.entries) ...{
                      'attachment[${entry.key}]': entry.value
                    }
                  }
                };
                print('updateData $updateData');
                provider.updatePickup(
                  context,
                  updateData,
                  data.id,
                );
              }
            },
            destinationTitle: data.customer.name,
            currentLocation: Coords(
              _driverLatLng.first.latitude,
              _driverLatLng.first.longitude,
            ),
            title: "${widget.data.name} ⁃ ${data.customer.name}",
          ),
          isDarkMode: false,
        );
      }
    }
  }

  routeStatusDialog() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                'Route Status',
                style: AppStyles.text14PxRegular,
              ),
              content: CustomDropdown(
                items: AppConstants.getStatusList,
                selectedValue: selectedRouteStatus,
                label: '',
                onChanged: (value) {
                  print('value--> $value');
                  setState(() {
                    selectedRouteStatus = value;
                  });
                  print('selectedRouteStatus--> $selectedRouteStatus');
                },
              ),
              actions: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: const Text('Update'),
                  onPressed: () {
                    var provider = context.read<ProutesDetailProvider>();
                    var selectedKey = AppConstants.getStatusList.firstWhere(
                      (element) => element['value'] == selectedRouteStatus,
                      orElse: () {
                        print(
                            "No matching element found for value: $selectedRouteStatus");
                        return AppConstants.getStatusList.first;
                      },
                    )['key'];

                    print('selectedKey--> $selectedKey');
                    provider.updateRouteStatus(
                      context,
                      selectedRouteStatus,
                      widget.data.id,
                    );
                  },
                ),
              ],
            ));
  }

  Widget customerInformation(Pickup data, int index, routeId) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSizeDefault,
        vertical: Dimensions.paddingSizeEight,
      ),
      child: Container(
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
        child: Column(
          children: [
            ListTile(
              leading: Container(
                height: 40,
                width: 40,
                child: const CustomImage(
                  AppConstants.profileImage,
                  circular: true,
                ),
              ),
              title: Text(
                data.customer.name,
                style: AppStyles.text14PxMedium,
              ),
              subtitle: Text(
                DateUtility.getFormattedDate(
                  data.createdAt,
                ),
                style: AppStyles.text12PxRegular,
              ),
              onTap: () {
                setState(
                  () {
                    isCustomerExpandedList[index] =
                        !isCustomerExpandedList[index];
                  },
                );
              },
              dense: true,
              contentPadding: EdgeInsets.zero,
              trailing: Container(
                height: 32,
                width: 32,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.greySecondary,
                ),
                child: Icon(
                  isCustomerExpandedList[index]
                      ? Icons.keyboard_arrow_up_outlined
                      : Icons.keyboard_arrow_down_outlined,
                ),
              ),
            ),
            if (isCustomerExpandedList[index])
              Column(
                children: [
                  Gaps.verticalGapOf(10.0),
                  Utility().horizonDivider(
                    'Pickup Information',
                  ),
                  Gaps.verticalGapOf(10.0),
                  // ReusableWidget().commonTextRender(
                  //   'Pickup Date',
                  //   DateUtility.extractDate(
                  //     data.pickupDate,
                  //   ),
                  // ),
                  // Gaps.verticalGapOf(10.0),
                  // Consumer<LocationProvider>(
                  //   builder: (context, locationProvider, child) {
                  //     return ReusableWidget().commonTextRender(
                  //       'Address',
                  //       currentAddress,
                  //       onTap: () => LocationUtility.openMap(
                  //         locationProvider.currentLocation.latitude,
                  //         locationProvider.currentLocation.longitude,
                  //         double.parse(data.coordinates[0]),
                  //         double.parse(data.coordinates[1]),
                  //         data.customer.name,
                  //       ),
                  //     );
                  //   },
                  // ),
                  Consumer<LocationProvider>(
                    builder: (context, locationProvider, child) {
                      return ReusableWidget().commonTextRender(
                        'Address',
                        currentAddress,
                        onTap: () => LocationUtility.openMap(
                          locationProvider.currentLocation.latitude,
                          locationProvider.currentLocation.longitude,
                          data.coordinates[0],
                          data.coordinates[1],
                          data.customer.name,
                        ),
                      );
                    },
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
                    'Tare Weight',
                    data.tareWeight.join(','),
                  ),
                  Gaps.verticalGapOf(10.0),
                  ReusableWidget().commonTextRender(
                    'No. of Bins',
                    "${data.nBins}",
                  ),
                  Gaps.verticalGapOf(20.0),
                  Utility().horizonDivider(
                    'Materials Information',
                  ),
                  Gaps.verticalGapOf(15.0),
                  materialInformation(data, index),
                  Gaps.verticalGapOf(20.0),
                  if (data.image.isNotEmpty)
                    Utility().horizonDivider(
                      'Photos',
                    ),
                  if (data.image.isNotEmpty) Gaps.verticalGapOf(15.0),
                  if (data.image.isNotEmpty) pickupPhotos(data),
                  if (data.image.isNotEmpty) Gaps.verticalGapOf(20.0),
                  Gaps.verticalGapOf(15.0),
                  PEmergencyDetailWidget(
                    data: data,
                  ),
                  Gaps.verticalGapOf(15.0),

                  if (data.status != 'pending') Gaps.verticalGapOf(20.0),
                  if (data.status != 'pending' && data.status != 'done')
                    CustomMaterialButton(
                        label:
                            // (data.status == 'active')
                            //     ? 'Mark As Completed'
                            //     : data.status == 'pending'
                            //         ? 'Start Job'
                            //         : 'Update Schedule',
                            'Mark As Completed',
                        elevation: 0,
                        onTap: () {
                          // getCurrentLocation();

                          // if (_isFetchingLocation) {
                          //   CustomToast.show(
                          //       'Fetching location, please wait...',
                          //       isSuccess: true);
                          // } else if (data.status == 'pending' &&
                          //     widget.data.driverCoordinates == null) {
                          //   BottomModelSheet.showCustomModalBottomSheet(
                          //     context: context,
                          //     modal: MapsList(
                          //       location: Coords(
                          //         data.coordinates[0],
                          //         data.coordinates[1],
                          //       ),
                          //       type: AppConstants.pickup,
                          //       onMapSelected: (map) {
                          //         var provider =
                          //             context.read<ProutesDetailProvider>();
                          //         var currentDate = DateTime.now();
                          //         var driverCoordinatesWithIndex = _driverLatLng
                          //             .asMap()
                          //             .map((key, value) =>
                          //                 MapEntry(key.toString(), value));
                          //         if (data.status == 'pending') {
                          //           Map<String, dynamic> updateData = {
                          //             'status': data.status == 'pending'
                          //                 ? 'active'
                          //                 : 'pending',
                          //             "started_at": DateUtility.formatDateTime(
                          //                 currentDate),
                          //             if (driverCoordinatesWithIndex
                          //                 .isNotEmpty) ...{
                          //               for (var entry
                          //                   in driverCoordinatesWithIndex
                          //                       .entries) ...{
                          //                 'attachment[${entry.key}]':
                          //                     entry.value
                          //               }
                          //             }
                          //           };
                          //           print('updateData $updateData');
                          //           provider.updatePickup(
                          //             context,
                          //             updateData,
                          //             data.id,
                          //           );
                          //         }
                          //       },
                          //       destinationTitle: data.customer.name,
                          //       currentLocation: Coords(
                          //         _driverLatLng.first.latitude,
                          //         _driverLatLng.first.longitude,
                          //       ),
                          //       title:
                          //           "${widget.data.name} ⁃ ${data.customer.name}",
                          //     ),
                          //     isDarkMode: false,
                          //   );
                          // } else {
                          Utility.navigateMaterialRoute(
                            context,
                            PickupUpdateScreen(
                              data: data,
                            ),
                          );
                          // }
                        }),
                ],
              )
          ],
        ),
      ),
    );
  }

  customerTitle() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSizeDefault,
        vertical: Dimensions.paddingSizeEight,
      ),
      child: TitleActionChild(
        title: 'Customer Information',
        titleStyle: AppStyles.text14PxMedium,
        child: const SizedBox.shrink(),
      ),
    );
  }

  materialInformation(Pickup data, int index) {
    return PickupMaterialTable(
      material: data.materials,
    );
  }

  pickupPhotos(Pickup data) {
    return Row(
      children: [
        ...List.generate(
          data.image.length,
          (index) => ReusableWidget.buildSmallProductPreview(
            context,
            data.image.cast<String>(),
            index,
          ),
        ),
      ],
    );
  }
}
