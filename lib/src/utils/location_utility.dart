import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smc_flutter/src/src.dart';

class LocationUtility {
  static getAddress(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];

      return Utility.isAccessible(place.subLocality)
          ? '${place.subLocality}, ${place.locality}'
          : '${place.locality}';
    } catch (e) {
      return 'Address not found';
    }
  }

  static Future<String> getCurrentAddress() async {
    LocationProvider locationProvider = LocationProvider();
    var currentAddress = await locationProvider.getUserAddress();

    return currentAddress;
  }

  static locality(double latitude, double longitude) async {
    // Assuming currentPlacemark is not null
    String? placeName;
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    Placemark currentPlacemark = placemarks[0];

    if (currentPlacemark.street != null &&
        !currentPlacemark.street!.contains("+")) {
      placeName = currentPlacemark.street;
    } else if (currentPlacemark.subLocality != null &&
        currentPlacemark.subLocality!.isNotEmpty) {
      placeName = currentPlacemark.subLocality;
    } else if (currentPlacemark.subAdministrativeArea != null &&
        currentPlacemark.subAdministrativeArea!.isNotEmpty) {
      placeName = currentPlacemark.subAdministrativeArea;
    } else if (currentPlacemark.thoroughfare != null &&
        currentPlacemark.thoroughfare!.isNotEmpty) {
      placeName = currentPlacemark.thoroughfare;
    } else if (currentPlacemark.subThoroughfare != null &&
        currentPlacemark.subThoroughfare!.isNotEmpty) {
      placeName = currentPlacemark.subThoroughfare;
    } else if (currentPlacemark.postalCode != null &&
        currentPlacemark.postalCode!.isNotEmpty) {
      placeName = currentPlacemark.postalCode;
    } else {
      placeName =
          currentPlacemark.street; // Default to street if no other value found
    }
    print("Debug: placeName = $placeName");

    return placeName;
  }

  static Future<LatLng?> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return null;
      }

      // Get the current position of the device
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Return the current position as LatLng
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      print("Error getting current location: $e");
      return null;
    }
  }

  static customMarker(String symbol, Color color) {
    return Stack(
      children: [
        Icon(
          Icons.add_location,
          color: color,
          size: 50,
        ),
        Positioned(
          left: 15,
          top: 8,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                Dimensions.radiusDefault,
              ),
            ),
            child: Center(
              child: Text(
                symbol,
              ),
            ),
          ),
        )
      ],
    );
  }

  static Future<void> openMap(
    double userLatitude,
    double userLongitude,
    double destinationLatitude,
    double destinationLongitude,
    String customerName,
  ) async {
    String googleUrl = '${AppConstants.inAppMapUrl}$userLatitude,$userLongitude'
        '&destination=$destinationLatitude,$destinationLongitude&mode=d';
    await launchInBrowser(
      googleUrl,
    );
  }
}
