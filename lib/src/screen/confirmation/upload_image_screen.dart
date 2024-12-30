import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smc_flutter/src/src.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  final List<XFile> _images = [];

  Future<void> _getImages() async {
    try {
      final List<XFile> pickedFiles = await ImagePicker().pickMultiImage();
      setState(() {
        _images.addAll(pickedFiles); // Append pickedFiles to _images
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Confirmation',
        centerTitle: true,
        isBackButtonExist: true,
        isNotification: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Gaps.verticalGapOf(10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: _images.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      customInkwell(
                        onTap: () => Utility.navigateMaterialRoute(
                          context,
                          CustomPhotoViewer(
                            imageUrls:
                                _images.map((image) => image.path).toList(),
                            initialIndex: index,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              15.0), // Customize border radius here
                          child: Image.file(
                            File(_images[index].path),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          icon: const Icon(Icons.highlight_remove_rounded),
                          color: Colors.red,
                          onPressed: () {
                            setState(() {
                              _images.removeAt(index);
                            });
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          if (_images.isEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 190),
              child: Center(
                child: CustomMaterialButton(
                  label: 'Upload Images for confirmation',
                  fillButton: false,
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(0.1),
                  color: AppColors.kPitchBlackColor,
                  width: MediaQuery.of(context).size.width * 0.7,
                  radius: 20,
                  height: 250,
                  elevation: 0,
                  // icon: Assets.weight,

                  onTap: _getImages,
                ),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: CustomMaterialButton(
                label: '+ Add More Images ',
                fillButton: false,
                backgroundColor:
                    Theme.of(context).primaryColor.withOpacity(0.1),
                color: AppColors.kPitchBlackColor,
                width: MediaQuery.of(context).size.width * 0.3,
                radius: 20,
                height: 60,
                elevation: 0,
                onTap: _getImages,
              ),
            ),
          Gaps.verticalGapOf(15),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: CustomMaterialButton(
              label: 'Submit',
              onTap: () {},
            ),
          )
        ],
      ),
    );
  }
}
