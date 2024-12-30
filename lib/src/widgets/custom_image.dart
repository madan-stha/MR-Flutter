import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../src.dart';

class CustomImage extends StatelessWidget {
  final String imagePath;
  final bool cover;
  final double? width;
  final bool circular;
  final double? height;
  final CustomImageType imageType;
  final Widget placeholder;
  final double borderRadius;
  final Color? borderColor;
  final bool border;

  const CustomImage(
    this.imagePath, {
    super.key,
    this.cover = true,
    this.width,
    this.height,
    this.circular = false,
    this.imageType = CustomImageType.network,
    this.border = false,
    this.borderColor,
    this.placeholder = const Center(
      child: CircularProgressIndicator(),
    ),
    this.borderRadius = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    switch (imageType) {
      case CustomImageType.local:
        return _buildLocalImage(imagePath);
      case CustomImageType.network:
        return _buildNetworkImage(imagePath);
    }
  }

  Widget _buildLocalImage(String path) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image.asset(
          path,
          fit: cover ? BoxFit.cover : BoxFit.contain,
          width: width,
          height: height,
          errorBuilder: (context, error, stackTrace) => ClipRRect(
            child: Image.asset(
              Assets.placeholder,
              height: height,
              width: width,
              fit: cover ? BoxFit.cover : BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNetworkImage(String path) {
    return CachedNetworkImage(
      imageUrl: path,
      fit: cover ? BoxFit.cover : BoxFit.contain,
      width: width,
      height: height,
      imageBuilder: (context, imageProvider) => Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius:
              borderRadius != 0.0 ? BorderRadius.circular(borderRadius) : null,
          border: border
              ? Border.all(
                  width: 2,
                  color: borderColor ?? Theme.of(context).primaryColor)
              : null,
          shape: circular ? BoxShape.circle : BoxShape.rectangle,
          image: DecorationImage(
            image: imageProvider,
            fit: cover ? BoxFit.cover : BoxFit.contain,
          ),
        ),
      ),
      placeholder: (context, url) => placeholder,
      errorWidget: (context, url, error) => Container(
        decoration: BoxDecoration(
          color: AppColors.greySecondary,
          border: border
              ? Border.all(
                  width: 2,
                  color: borderColor ?? Theme.of(context).primaryColor)
              : null,
          shape: circular ? BoxShape.circle : BoxShape.rectangle,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          clipBehavior: Clip.antiAlias,
          child: Image.asset(
            Assets.placeholder,
            height: height,
            width: width,
            fit: cover ? BoxFit.cover : BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
