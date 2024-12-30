import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../src.dart';

class SvgHelper {
  static Widget fromSource({
    required String path,
    SvgSourceType type = SvgSourceType.asset,
    double height = 20,
    double width = 20,
    Color? color,
  }) {
    switch (type) {
      case SvgSourceType.asset:
        return _buildAssetSvg(path, height, width, color);
      case SvgSourceType.network:
        return _buildNetworkSvg(path, height, width, color);
    }
  }

  static Widget _buildAssetSvg(
    String assetName,
    double height,
    double width,
    Color? color,
  ) {
    return SvgPicture.asset(
      assetName,
      height: height,
      width: width,
      fit: BoxFit.contain,
      colorFilter:
          color == null ? null : ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  static Widget _buildNetworkSvg(
    String url,
    double height,
    double width,
    Color? color,
  ) {
    return SvgPicture.network(
      url,
      height: height,
      width: width,
      fit: BoxFit.contain,
      colorFilter:
          color == null ? null : ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
