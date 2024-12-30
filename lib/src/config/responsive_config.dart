import 'package:flutter/widgets.dart';

class SizeConfig {
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double _blockWidth = 0;
  static double _blockHeight = 0;
  static bool isLargerScreen = false;

  static double textMultiplier = 0;
  static double imageSizeMultiplier = 0;
  static double heightMultiplier = 0;
  static double widthMultiplier = 0;
  static bool isPortrait = true;
  static bool isMobilePortrait = false;
  static bool isTablet = false;
  static bool isTabletLandcsape = false;

  //minimum width for tablet to show FragmentA and FragmentB on the same screen
  static const minWidth = 1100;

  // common breakpoint for 7-inch tablet device

  static const minPhoneSize = 480;
  static const minTabletSize = 768;
  static const minDesktopSize = 1440;
  static const minMobileLandscapeSize = 600;

  // Font sizes
  static Map<String, double> fontSizes = {};

  // static const SIZE_THRESHOLD=480

  void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      screenWidth = constraints.maxWidth;
      screenHeight = constraints.maxHeight;
      isPortrait = true;
      if (screenWidth < minPhoneSize) {
        isMobilePortrait = true;
        isTablet = false;
      } else if (screenWidth > minTabletSize) {
        isTablet = true;
      }
      if (constraints.maxWidth >= minWidth) {
        isLargerScreen = true;
      } else {
        isLargerScreen = false;
      }
    } else {
      screenWidth = constraints.maxHeight;
      screenHeight = constraints.maxWidth;
      if (constraints.maxWidth >= minTabletSize) {
        isTablet = true;
      }
      //condition for switching to fragment layout
      if (constraints.maxWidth >= minWidth) {
        isLargerScreen = true;
      } else {
        isLargerScreen = false;
      }
      isPortrait = false;
      isMobilePortrait = false;
    }
    if (isTablet) {
      if (orientation == Orientation.landscape) {
        isTabletLandcsape = true;
      }
    }
    if (screenWidth >= minDesktopSize && orientation == Orientation.landscape) {
      isTablet = false;
      isLargerScreen = true;
      isPortrait = false;
      isMobilePortrait = false;
      isTabletLandcsape = false;
    }

// for mobile landscape
    // if (orientation == Orientation.landscape &&
    //     screenWidth >= MIN_LANDSCAPE_MOBILE_WIDTH) {
    //   isMobilePortrait = false;
    //   isTablet = false;
    //   isLargerScreen = false;
    //   isTabletLandcsape = false;
    // }

    _blockWidth = screenWidth / 100;
    _blockHeight = screenHeight / 100;

    textMultiplier = _blockHeight;
    imageSizeMultiplier = _blockWidth;
    heightMultiplier = _blockHeight;
    widthMultiplier = _blockWidth;
  }
}
