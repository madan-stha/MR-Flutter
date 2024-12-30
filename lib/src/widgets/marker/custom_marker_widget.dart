// import 'dart:typed_data';
// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:smc_flutter/src/src.dart';

// class CustomMapMarkerBuilder extends StatefulWidget {
//   final List<Widget> markerWidgets;

//   final Widget Function(BuildContext context, List<Uint8List>? imagesData)
//       builder;

//   const CustomMapMarkerBuilder({
//     super.key,
//     required this.markerWidgets,
//     required this.builder,
//   });

//   @override
//   State<CustomMapMarkerBuilder> createState() => _CustomMapMarkerBuilderState();
// }

// class _CustomMapMarkerBuilderState extends State<CustomMapMarkerBuilder> {
//   List<Uint8List>? _markerImagesData;

//   @override
//   void initState() {
//     super.initState();
//     _generateMarkerImages();
//   }

//   _generateMarkerImages() async {
//     List<Uint8List> images = [];
//     for (var widget in widget.markerWidgets) {
//       images.add(await _captureWidget(widget));
//     }
//     setState(() {
//       _markerImagesData = images;
//     });
//   }

// Future<Uint8List> _captureWidget(Widget widget) async {
//   RenderRepaintBoundary boundary = RenderRepaintBoundary();
//   Widget wrappedWidget = Builder(
//     builder: (BuildContext context) {
//       return widget;
//     },
//   );
//   RenderBox renderBox = (wrappedWidget.key as GlobalKey).currentContext!.findRenderObject() as RenderBox;
//   // Get the parent of the render box
//   RenderObject? parent = renderBox.parent;
//   if (parent != null) {
//     // Add the boundary as a child of the parent
//     parent.attach(owner)
//     await Future.delayed(const Duration(milliseconds: 20));
//     boundary.child!.layout(BoxConstraints.tight(renderBox.size));
//     var image = await boundary.toImage(pixelRatio: 3.0);
//     var byteData = await image.toByteData(format: ImageByteFormat.png);
//     return byteData!.buffer.asUint8List();
//   } else {
//     throw FlutterError('Failed to capture widget: RenderBox has no parent.');
//   }
// }


//   @override
//   Widget build(BuildContext context) {
//     return widget.builder(context, _markerImagesData);
//   }
// }

// class CustomGoogleMapMarkerBuilder extends StatelessWidget {
//   final List<MarkerModel> customMarkers;
//   final Widget Function(BuildContext, Set<Marker>? markers) builder;

//   const CustomGoogleMapMarkerBuilder({
//     super.key,
//     required this.customMarkers,
//     required this.builder,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return CustomMapMarkerBuilder(
//       markerWidgets:
//           customMarkers.map((customMarker) => customMarker.child).toList(),
//       builder: (BuildContext context, List<Uint8List>? customMarkerImagesData) {
//         Set<Marker>? markers;
//         if (customMarkerImagesData != null) {
//           markers = {};
//           for (int i = 0; i < customMarkerImagesData.length; i++) {
//             final marker = Marker(
//               markerId: MarkerId(i.toString()),
//               position: const LatLng(0, 0), // Set position as needed
//               icon: BitmapDescriptor.fromBytes(customMarkerImagesData[i]),
//             );
//             markers.add(marker);
//           }
//         }
//         return builder(context, markers);
//       },
//     );
//   }
// }
