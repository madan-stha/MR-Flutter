import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../../src.dart';

class MapScreen extends StatefulWidget {
  final DeliveryDetailModel address;
  const MapScreen({super.key, required this.address});

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  late LatLng _driverLatLng;
  late LatLng _customerLatLng;
  LatLng? _currentLatLng;
  Set<Marker> markers = {};
  Set<Marker> get _markers => markers;
  PolylinePoints polylinePoints = PolylinePoints();
  String driverAddress = 'Loading...';
  String customerAddress = 'Loading...';
  String currentAddress = 'Loading...';
  Set<Polyline> polylines = {};
  Set<Polyline> get _polylines => polylines;
  late Location _location;
  late StreamSubscription<LocationData> _locationSubscription;
  GoogleMapController? _mapController;
  bool isDriverCoordinatesAvailable = false;

  @override
  void initState() {
    super.initState();
    _customerLatLng = const LatLng(0, 0);
    polylinePoints = PolylinePoints();
    _location = Location();

    fetchData();
    _startLocationTracking();
  }

  @override
  void dispose() {
    _locationSubscription.cancel();
    super.dispose();
  }

  Future<void> fetchData() async {
    try {
      if (widget.address.coordinate.isNotEmpty) {
        List<dynamic> customerCoordinates = widget.address.coordinate;
        _customerLatLng = LatLng(
          double.parse(customerCoordinates[0].toString().trim()),
          double.parse(customerCoordinates[1].toString().trim()),
        );
        final cAddress = await LocationUtility.getAddress(
          _customerLatLng.latitude,
          _customerLatLng.longitude,
        );
        setState(() {
          customerAddress = cAddress;
        });
      }

      if (widget.address.driverCoordinates.isNotEmpty) {
        List<dynamic> driverCoordinates = widget.address.driverCoordinates;
        _driverLatLng = LatLng(
          double.parse(driverCoordinates[0].toString().trim()),
          double.parse(driverCoordinates[1].toString().trim()),
        );
        final dAddress = await LocationUtility.getAddress(
          _driverLatLng.latitude,
          _driverLatLng.longitude,
        );
        setState(() {
          driverAddress = dAddress;
          isDriverCoordinatesAvailable = true;
        });
      } else {
        setState(() {
          isDriverCoordinatesAvailable = false;
        });
      }

      _currentLatLng = await _getCurrentLocation();
      setMarkers();
      _drawPolyline();
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<LatLng?> _getCurrentLocation() async {
    final currentLocation = await LocationUtility.getCurrentLocation();

    if (currentLocation != null) {
      final curAddress = await LocationUtility.getAddress(
        currentLocation.latitude,
        currentLocation.longitude,
      );
      setState(() {
        currentAddress = curAddress;
      });

      return LatLng(
        currentLocation.latitude,
        currentLocation.longitude,
      );
    }
    return null;
  }

  void _startLocationTracking() {
    _locationSubscription = _location.onLocationChanged.listen((locationData) {
      // if (locationData != null) {
      //   final newLatLng =
      //       LatLng(locationData.latitude!, locationData.longitude!);
      //   setState(() {
      //     _currentLatLng = newLatLng;
      //     currentAddress = 'Updating...'; // Optionally update address here
      //   });
      //   setMarkers();
      // }
    });
  }

  void setMarkers() async {
    final Uint8List driverIcon = await convertAssetToUnit8List(
      Assets.driver,
    );

    final Uint8List customerIcon = await convertAssetToUnit8List(
      Assets.customer,
    );
    final Uint8List currentIcon = await convertAssetToUnit8List(
      Assets.marker,
    );

    setState(() {
      _setMarker(_customerLatLng, 'Customer',
          BitmapDescriptor.fromBytes(customerIcon), customerAddress);

      if (isDriverCoordinatesAvailable) {
        _setMarker(_driverLatLng, 'Driver',
            BitmapDescriptor.fromBytes(driverIcon), driverAddress);
      }

      if (_currentLatLng != null) {
        _setMarker(_currentLatLng!, 'Current',
            BitmapDescriptor.fromBytes(currentIcon), currentAddress);
      }
    });
  }

  void _setMarker(
      LatLng position, String markerId, BitmapDescriptor icon, String address) {
    _markers.add(
      Marker(
        markerId: MarkerId(markerId),
        position: position,
        infoWindow: InfoWindow(
          title: address,
          anchor: const Offset(
            0.5,
            0.5,
          ),
          snippet: markerId,
        ),
        icon: icon,
      ),
    );
  }

  void _drawPolyline() async {
    if (isDriverCoordinatesAvailable) {
      try {
        PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          AppConstants.googleMapApiKey,
          PointLatLng(_driverLatLng.latitude, _driverLatLng.longitude),
          PointLatLng(_customerLatLng.latitude, _customerLatLng.longitude),
          travelMode: TravelMode.driving,
          optimizeWaypoints: true,
        );

        if (result.points.isNotEmpty) {
          List<LatLng> polylineCoordinates = result.points
              .map((point) => LatLng(point.latitude, point.longitude))
              .toList();

          setState(() {
            _polylines.add(
              Polyline(
                polylineId: const PolylineId('route'),
                points: polylineCoordinates,
                color: Theme.of(context).primaryColor,
                width: 3,
              ),
            );
          });
        } else {
          print("No polyline points found");
        }
      } catch (e) {
        print("Error drawing polyline: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Live Tracking',
        radius: false,
        actions: [
          if (widget.address.status != 'completed')
            CustomTextButton(
              text: 'Complete',
              textStyle: AppStyles.text14PxMedium.copyWith(
                color: AppColors.white,
              ),
              onPressed: () {
                Utility.navigateMaterialRoute(
                  context,
                  DeliveryUpdateScreen(
                    data: widget.address,
                  ),
                );
              },
            ),
        ],
      ),
      body: Center(
        child: SizedBox(
          width: double.infinity,
          child: Stack(children: [
            GoogleMap(
              mapType: MapType.normal,
              minMaxZoomPreference: const MinMaxZoomPreference(0, 20),
              initialCameraPosition: CameraPosition(
                target: _customerLatLng,
                zoom: 14,
              ),
              zoomGesturesEnabled: true,
              myLocationButtonEnabled: false,
              mapToolbarEnabled: true,
              zoomControlsEnabled: false,
              markers: _markers.toSet(),
              polylines: _polylines.toSet(),
              onMapCreated: (controller) {
                _mapController = controller;
              },
              onCameraIdle: () {
                print("Camera idle...");
              },
              onCameraMove: (position) {
                print("Camera moving...");
              },
              onCameraMoveStarted: () {
                print("Camera moving...");
              },
            ),
            Positioned(
              left: Dimensions.paddingSizeDefault,
              right: Dimensions.paddingSizeDefault,
              bottom: Dimensions.paddingSizeDefault,
              child: InkWell(
                onTap: () {
                  if (_mapController != null) {
                    _mapController!.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: _customerLatLng,
                          zoom: 17,
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeEight,
                    vertical: Dimensions.paddingSizeDefault,
                  ),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Dimensions.radiusDefault),
                    color: Theme.of(context).canvasColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[300]!,
                        spreadRadius: 3,
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (isDriverCoordinatesAvailable)
                        buildDriverInfo(context)
                      else
                        buildStartTrackingButton(context),
                      Gaps.verticalGapOf(
                          !isDriverCoordinatesAvailable ? 15.0 : 0.0),
                      buildCustomerInfo(context),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget buildDriverInfo(BuildContext context) {
    return Column(
      children: [
        customInkwell(
          onTap: () {
            _mapController!.animateCamera(
              CameraUpdate.newLatLngZoom(_driverLatLng, 17),
            );
          },
          child: ReusableWidget().iconValue(
            icon: Assets.order,
            title: 'Pickup : ',
            value: driverAddress,
            isBold: true,
          ),
        ),
        Gaps.verticalGapOf(15.0),
      ],
    );
  }

  Widget buildStartTrackingButton(BuildContext context) {
    return CustomMaterialButton(
      label: 'Start Tracking',
      onTap: () {
        var updateProvider = context.read<DeliveryDetailProvider>();

        updateProvider.updateData(
          context: context,
          id: widget.address.id,
          // type: 'start',
          // status: "in_progress",
          // coordinates: [
          //   "${_currentLatLng!.latitude}".toString(),
          //   "${_currentLatLng!.longitude}".toString(),
          // ],
        );
      },
      height: 35,
      radius: 60,
      elevation: 0,
    );
  }

  Widget buildCustomerInfo(BuildContext context) {
    return Column(
      children: [
        customInkwell(
          onTap: () {
            _mapController!.animateCamera(
              CameraUpdate.newLatLngZoom(_customerLatLng, 17),
            );
          },
          child: ReusableWidget().iconValue(
            icon: Assets.user,
            title: 'Deliver : ',
            value: customerAddress,
            isBold: true,
          ),
        ),
        Gaps.verticalGapOf(15.0),
        customerInformation(
          name: widget.address.customer.name,
          phoneNumber: widget.address.customer.contact,
        ),
      ],
    );
  }

  Widget customerInformation(
      {String? name, String? profileImage, String? phoneNumber}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.greySecondary,
        ),
        borderRadius: BorderRadius.circular(Dimensions.radiusExtraMoreLarge),
      ),
      padding: const EdgeInsets.all(
        Dimensions.paddingSizeEight,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CustomImage(
                Assets.user,
                height: 30,
                width: 30,
                border: true,
                circular: true,
              ),
              Gaps.horizontalGapOf(10.0),
              Column(
                children: [
                  Text(
                    name ?? 'Please wait...',
                    style: AppStyles.text12PxMedium,
                  ),
                  Text(
                    phoneNumber ?? 'Please wait...',
                    style: AppStyles.text12PxRegular,
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReusableWidget().roundedIcon(
                context,
                icon: Icons.map_outlined,
                onTap: () {},
              ),
              if (Utility.isAccessible(phoneNumber)) Gaps.horizontalGapOf(10.0),
              if (Utility.isAccessible(phoneNumber))
                ReusableWidget().roundedIcon(
                  context,
                  icon: Icons.phone_outlined,
                  onTap: () {
                    launchInBrowser(
                      'tel: ${phoneNumber ?? ''}',
                    );
                  },
                ),
            ],
          )
        ],
      ),
    );
  }

  Future<Uint8List> convertAssetToUnit8List(String imagePath,
      {int width = 100}) async {
    ByteData data = await rootBundle.load(imagePath);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
