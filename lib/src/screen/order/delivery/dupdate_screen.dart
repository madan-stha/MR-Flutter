import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../src.dart';

class DeliveryUpdateScreen extends StatefulWidget {
  final DeliveryDetailModel data;
  const DeliveryUpdateScreen({super.key, required this.data});

  @override
  State<DeliveryUpdateScreen> createState() => _DeliveryUpdateScreenState();
}

class _DeliveryUpdateScreenState extends State<DeliveryUpdateScreen> {
  DateTime endTime = DateTime.now();

  final List<XFile> _images = [];

  Future<void> _getImages() async {
    try {
      final List<XFile> pickedFiles = await ImagePicker().pickMultiImage(
        limit: widget.data.items.length == 1
            ? widget.data.items.length + 1
            : widget.data.items.length,
        imageQuality: 60,
      );
      setState(() {
        _images.addAll(pickedFiles);
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('images itesm ${widget.data.items.length}');
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Completed Order',
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(
              Dimensions.radiusDefault,
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault,
            vertical: Dimensions.paddingSizeEight,
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeEight,
            vertical: Dimensions.paddingSizeExtraSmall,
          ),
          child: Column(
            children: [
              TitleActionChild(
                title: 'Start Time',
                titlePadding: const EdgeInsets.only(
                  bottom: 10.0,
                ),
                child: CustomTextField2(
                  hintText: widget.data.startedAt,
                  prefixIcon: const Icon(
                    Icons.time_to_leave_outlined,
                  ),
                  isReadOnly: true,
                ),
              ),
              Gaps.verticalGapOf(
                16.0,
              ),
              TitleActionChild(
                title: 'End Time',
                titlePadding: const EdgeInsets.only(
                  bottom: 10.0,
                ),
                child: CustomTextField2(
                  hintText: endTime.toString(),
                  prefixIcon: const Icon(
                    Icons.history_rounded,
                  ),
                  isReadOnly: true,
                ),
              ),
              Gaps.verticalGapOf(
                16.0,
              ),
              if (_images.isNotEmpty)
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.lightGreenColor,
                    borderRadius: BorderRadius.circular(
                      Dimensions.radiusDefault,
                    ),
                    border: Border.all(
                      color: AppColors.greyColor,
                      width: 1.0,
                    ),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 1,
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
                                width: 80,
                                height: 80,
                              ),
                            ),
                          ),
                          Positioned(
                            top: -15,
                            // bottom: -20,
                            right: 40,
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
              if (_images.isEmpty || widget.data.items.length != _images.length)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Center(
                    child: CustomMaterialButton(
                      label: 'Upload Images for confirmation',
                      fillButton: false,
                      backgroundColor:
                          Theme.of(context).primaryColor.withOpacity(0.1),
                      color: AppColors.kPitchBlackColor,
                      width: MediaQuery.of(context).size.width * 0.7,
                      radius: 20,
                      height: 50,
                      elevation: 0,
                      onTap: _getImages,
                    ),
                  ),
                ),
              // else
              //   Padding(
              //     padding: const EdgeInsets.only(left: 20),
              //     child: CustomMaterialButton(
              //       label: '+ Add More Images ',
              //       fillButton: false,
              //       backgroundColor:
              //           Theme.of(context).primaryColor.withOpacity(0.1),
              //       color: AppColors.kPitchBlackColor,
              //       width: MediaQuery.of(context).size.width * 0.3,
              //       radius: 20,
              //       height: 50,
              //       elevation: 0,
              //       onTap: _getImages,
              //     ),
              // ),
              Gaps.verticalGapOf(15),
              CustomMaterialButton(
                label: 'Submit',
                onTap: () {
                  var updateProvider = context.read<DeliveryDetailProvider>();

                  // var attachmentwithIndex = _images
                  // .asMap()
                  // .map((key, value) => MapEntry(key.toString(), value.path));

                  Map<String, dynamic> body = {
                    "status": "completed",
                    "ended_at": DateUtility.formatDateTime(
                      endTime,
                    ),
                    // if (attachmentwithIndex.isNotEmpty) ...{
                    //   for (var entry in attachmentwithIndex.entries) ...{
                    //     'attachment[${entry.key}]': entry.value
                    //   }
                    // }
                  };

                  print('body $body');
                  updateProvider.updateData(
                    context: context,
                    id: widget.data.id,
                    updateObj: body,
                    images: _images,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
