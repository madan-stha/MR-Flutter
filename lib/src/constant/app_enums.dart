// Svg Source
enum SvgSourceType {
  asset,
  network,
}

// Image Source
enum CustomImageType {
  local,
  network,
}

// Environment
enum Environment {
  local,
  production,
}

// Progress Bar Type
enum ProgressType { circular, linear }

// Progress Head Type
enum ProgressHeadType {
  circular,
  square,
}

enum ToastLength {
  /// Show for 1 sec
  short,

  /// Show for 5 sec
  long,
}

// No Data Found Type
enum NoDataType {
  notification,
  others,
  home,
  pickup,
  delivery,
  profile,
}
