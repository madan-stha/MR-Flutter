// import 'package:flutter/material.dart';

// import '../../../../src.dart';

// class CustomerDetailWidget extends StatefulWidget {
//   final Pickup data;
//   final int index;
//   final routeId;

//   const CustomerDetailWidget({super.key, required this.data, required this.index, required this.routeId});

//   @override
//   State<CustomerDetailWidget> createState() => _CustomerDetailWidgetState();
// }

// class _CustomerDetailWidgetState extends State<CustomerDetailWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(
//         horizontal: Dimensions.paddingSizeDefault,
//         vertical: Dimensions.paddingSizeEight,
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//           color: AppColors.white,
//           borderRadius: BorderRadius.circular(
//             Dimensions.radiusDefault,
//           ),
//         ),
//         padding: const EdgeInsets.symmetric(
//           horizontal: Dimensions.paddingSizeDefault,
//           vertical: Dimensions.paddingSizeEight,
//         ),
//         child: Column(
//           children: [
//             ListTile(
//               leading: Container(
//                 height: 40,
//                 width: 40,
//                 child: const CustomImage(
//                   AppConstants.profileImage,
//                   circular: true,
//                 ),
//               ),
//               title: Text(
//                 widget.data.customer.name,
//                 style: AppStyles.text14PxMedium,
//               ),
//               subtitle: Text(
//                 DateUtility.getFormattedDate(
//                   widget.data.createdAt,
//                 ),
//                 style: AppStyles.text12PxRegular,
//               ),
//               onTap: () {
//                 setState(
//                   () {
//                     isCustomerExpandedList[widget.index] =
//                         !isCustomerExpandedList[widget.index];
//                   },
//                 );
//               },
//               dense: true,
//               contentPadding: EdgeInsets.zero,
//               trailing: Container(
//                 height: 32,
//                 width: 32,
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: AppColors.greySecondary,
//                 ),
//                 child: Icon(
//                   isCustomerExpandedList[widget.index]
//                       ? Icons.keyboard_arrow_up_outlined
//                       : Icons.keyboard_arrow_down_outlined,
//                 ),
//               ),
//             ),
//             if (isCustomerExpandedList[widget.index])
//               Column(
//                 children: [
//                   Gaps.verticalGapOf(10.0),
//                   Utility().horizonDivider(
//                     'Pickup Information',
//                   ),
//                   Gaps.verticalGapOf(10.0),
//                   // ReusableWidget().commonTextRender(
//                   //   'Pickup Date',
//                   //   DateUtility.extractDate(
//                   //     data.pickupDate,
//                   //   ),
//                   // ),
//                   // Gaps.verticalGapOf(10.0),
//                   Consumer<LocationProvider>(
//                     builder: (context, locationProvider, child) {
//                       return ReusableWidget().commonTextRender(
//                         'Address',
//                         currentAddress,
//                         onTap: () => LocationUtility.openMap(
//                           locationProvider.currentLocation.latitude,
//                           locationProvider.currentLocation.longitude,
//                           double.parse(widget.data.coordinates[0]),
//                           double.parse(widget.data.coordinates[1]),
//                           widget.data.customer.name,
//                         ),
//                       );
//                     },
//                   ),
//                   Gaps.verticalGapOf(10.0),
//                   ReusableWidget().commonTextRender(
//                     'Status',
//                     Utility.getStatus(
//                       widget.data.status,
//                     ),
//                     style2: AppStyles.text12PxMedium.copyWith(
//                       color: Utility.getStatusColor(
//                         widget.data.status,
//                       ),
//                     ),
//                   ),
//                   Gaps.verticalGapOf(10.0),
//                   ReusableWidget().commonTextRender(
//                     'Tare Weight',
//                     widget.data.tareWeight.join(','),
//                   ),
//                   Gaps.verticalGapOf(10.0),
//                   ReusableWidget().commonTextRender(
//                     'No. of Bins',
//                     "${widget.data.nBins}",
//                   ),
//                   Gaps.verticalGapOf(20.0),
//                   Utility().horizonDivider(
//                     'Materials Information',
//                   ),
//                   Gaps.verticalGapOf(15.0),
//                   materialInformation(widget.data, widget.index),
//                   Gaps.verticalGapOf(20.0),
//                   if (widget.data.image.isNotEmpty)
//                     Utility().horizonDivider(
//                       'Photos',
//                     ),
//                   if (widget.data.image.isNotEmpty) Gaps.verticalGapOf(15.0),
//                   if (widget.data.image.isNotEmpty) pickupPhotos(widget.data),
//                   if (widget.data.image.isNotEmpty) Gaps.verticalGapOf(20.0),
//                   Gaps.verticalGapOf(20.0),
//                   CustomMaterialButton(
//                       label: (widget.data.status == 'active' &&
//                               widget.data.driverCoordinates != null)
//                           ? 'Mark As Completed'
//                           : 'Start Job',
//                       elevation: 0,
//                       onTap: () {
//                         var updateData = {
//                           "status": widget.data.status == 'active' &&
//                                   widget.data.driverCoordinates != null
//                               ? 'done'
//                               : 'active',
//                           if (widget.data.driverCoordinates != null)
//                             'driverCoordinates': _driverLatLng,
//                         };

//                         getCurrentLocation();
//                         if (_isFetchingLocation) {
//                           CustomToast.show('Fetching location, please wait...',
//                               isSuccess: true);
//                         } else if (widget.data.status == 'active' &&
//                             widget.data.driverCoordinates != null) {
//                           Utility.navigateMaterialRoute(
//                               context,
//                               PickupUpdateScreen(
//                                 data: widget.data,
//                               ));
//                         } else if (_driverLatLng.isNotEmpty) {
//                           BottomModelSheet.showCustomModalBottomSheet(
//                             context: context,
//                             modal: MapsList(
//                               location: Coords(
//                                 widget.data.coordinates[0],
//                                 widget.data.coordinates[1],
//                               ),
//                               type: AppConstants.pickup,
//                               onMapSelected: (map) {
//                                 context
//                                     .read<ProutesDetailProvider>()
//                                     .updateRouteStatus(
//                                       context,
//                                       widget.data.status == 'active' &&
//                                               widget.data.driverCoordinates !=
//                                                   null
//                                           ? 'done'
//                                           : 'active',
//                                       widget.routeId,
//                                     );
//                                 context
//                                     .read<ProutesDetailProvider>()
//                                     .updatePickup(
//                                       context,
//                                       updateData,
//                                       widget.data.status == 'active' &&
//                                               widget.data.driverCoordinates !=
//                                                   null
//                                           ? 'done'
//                                           : 'active',
//                                       widget.data.id,
//                                     );
//                               },
//                               destinationTitle: widget.data.customer.name,
//                               currentLocation: Coords(
//                                 _driverLatLng.first.latitude,
//                                 _driverLatLng.first.longitude,
//                               ),
//                               title:
//                                   "${widget.data.name} ⁃ ${widget.data.customer.name}",
//                             ),
//                             isDarkMode: false,
//                           );
//                         } else {
//                           CustomToast.show('No Driver Location Found');
//                         }
//                       }),
//                 ],
//               )
//           ],
//         ),
//       ),
//     );
  
//   }
// }