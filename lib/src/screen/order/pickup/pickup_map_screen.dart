import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smc_flutter/src/src.dart';

class PickupMapScreen extends StatefulWidget {
  final bool isShowStart;
  const PickupMapScreen({super.key, required this.isShowStart});

  @override
  State<PickupMapScreen> createState() => _PickupMapScreenState();
}

class _PickupMapScreenState extends State<PickupMapScreen> {
  GoogleMapController? mapController;
  late LatLng _driverLatLng;
  LatLng get driverLatLng => _driverLatLng;

  BitmapDescriptor myIcon = BitmapDescriptor.defaultMarker;
  Set<Polyline> polylines = {};
  Set<Polyline> get _polylines => polylines;
  List<LatLng> _polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  @override
  void initState() {
    super.initState();
    setCustomMarkerIcon();
    context.read<ProutesDetailProvider>().fetchData();
    getDriverLocation();
  }

  Future<void> setCustomMarkerIcon() async {
    final Uint8List markerMyIcon =
        await Utility.getBytesFromAsset(Assets.marker, 120);
    myIcon = BitmapDescriptor.fromBytes(markerMyIcon);
  }

  Future<void> getDriverLocation() async {
    if (widget.isShowStart) {
      setState(() {
        _driverLatLng = const LatLng(
          27.6888212,
          85.3450481,
        );
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Live Tracking',
        radius: false,
      ),
      body: Consumer<ProutesDetailProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            var customerCoordinates;
            for (var i = 0;
                i < provider.pickUpRoutesDetail.pickups.length;
                i++) {
              customerCoordinates =
                  provider.pickUpRoutesDetail.pickups[i].coordinates;
            }
            var customerLatitude = customerCoordinates[0];
            var customerLongitude = customerCoordinates[1];
            _getCustomerLocations(
              provider,
              _driverLatLng,
              LatLng(
                customerLatitude,
                customerLongitude,
              ),
            );
            return Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: _map(
                    context,
                    provider,
                  ),
                ),
                PickupBottomSheetScreen(
                  pickups: provider.pickUpRoutesDetail.pickups,
                  controller: mapController,
                ),
              ],
            );
          }
        },
      ),
    );
  }

  void _getCustomerLocations(
      ProutesDetailProvider provider, LatLng driver, LatLng customer) async {
    try {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        AppConstants.googleMapApiKey, // Your Google Maps API Key
        PointLatLng(driver.latitude, driver.longitude), // Origin coordinates
        PointLatLng(
            customer.latitude, customer.longitude), // Destination coordinates
        travelMode: TravelMode.driving, // Travel mode
      );

      if (result.points.isNotEmpty) {
        for (var point in result.points) {
          _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }

        // Create polyline options
        Polyline polyline = Polyline(
          polylineId: const PolylineId('route'),
          points: _polylineCoordinates,
          color: Theme.of(context).primaryColor,
          width: 3,
        );

        // Add polyline to polylines set
        setState(() {
          _polylines.add(polyline);
        });
      } else {
        print("No polyline points found");
      }
    } catch (e) {}
  }

  Set<Marker> _buildMarkers(List<Pickup> pickups) {
    return pickups.map((pickup) {
      final String id = pickup.id.toString();
      final double lat = pickup.coordinates[0];
      final double lng = pickup.coordinates[1];
      return Marker(
        markerId: MarkerId(id),
        position: LatLng(lat, lng),
        icon: myIcon,
        infoWindow: InfoWindow(
          title: pickup.customer.name,
          snippet: pickup.notes,
        ),
      );
    }).toSet();
  }

  Widget _map(BuildContext context, ProutesDetailProvider provider) {
    return GoogleMap(
      myLocationButtonEnabled: false,
      mapToolbarEnabled: true,
      zoomControlsEnabled: false,
      onMapCreated: (controller) {
        setState(() {
          mapController = controller;
        });
      },
      initialCameraPosition: CameraPosition(
        target: _driverLatLng,
        zoom: 10.0,
      ),
      markers: _buildMarkers(provider.pickUpRoutesDetail.pickups),
      polylines: _buildPolylines(),
    );
  }

  Set<Polyline> _buildPolylines() {
    Set<Polyline> polylines = {};

    for (int i = 0; i < _polylineCoordinates.length - 1; i++) {
      polylines.add(
        Polyline(
          polylineId: PolylineId('pickup_route_$i'),
          points: [_polylineCoordinates[i], _polylineCoordinates[i + 1]],
          color: Theme.of(context).primaryColor,
          width: 3,
        ),
      );
    }

    return polylines;
  }
}
