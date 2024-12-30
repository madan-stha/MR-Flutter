import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MarkersProvider extends ChangeNotifier {
  late final List<Uint8List?> _renderedWidgets;
  final int _childCount;
  int get childCount => _childCount;

  MarkersProvider({required int childCount}) : _childCount = childCount {
    _renderedWidgets = List<Uint8List?>.filled(childCount, null);
  }

  void updateRenderedImage(int index, Uint8List? data) {
    _renderedWidgets[index] = data;
    if (_ready) {
      notifyListeners();
    }
  }

  bool get _ready => !_renderedWidgets.any((image) => image == null);

  List<Uint8List>? get images =>
      _ready ? _renderedWidgets.cast<Uint8List>() : null;
}
