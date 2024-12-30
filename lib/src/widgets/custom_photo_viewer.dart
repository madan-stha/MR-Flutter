import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:smc_flutter/src/src.dart';

class CustomPhotoViewer extends StatelessWidget {
  final List<String> imageUrls;
  final int initialIndex;

  const  CustomPhotoViewer(
      {super.key, required this.imageUrls, this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPitchBlackColor,
      appBar: const CustomAppBar(
        bgColor: AppColors.kPitchBlackColor,
        title: 'Photo Viewer',
      ),
      body: PhotoViewGallery.builder(
        itemCount: imageUrls.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(imageUrls[index]),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        pageController: PageController(initialPage: initialIndex),
        backgroundDecoration: const BoxDecoration(
          color: Colors.black,
        ),
      ),
    );
  }
}
