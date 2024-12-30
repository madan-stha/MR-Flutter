import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerModel {
  final Marker marker;
  final Widget child;

  MarkerModel({required this.marker, required this.child});
}
