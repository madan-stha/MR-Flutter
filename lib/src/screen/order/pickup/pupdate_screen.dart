import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../src.dart';

class PickupUpdateScreen extends StatefulWidget {
  final Pickup data;

  const PickupUpdateScreen({super.key, required this.data});

  @override
  State<PickupUpdateScreen> createState() => _PickupUpdateScreenState();
}

class _PickupUpdateScreenState extends State<PickupUpdateScreen> {
  DateTime endTime = DateTime.now();

  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _materialController = TextEditingController();
  final TextEditingController _nBinsController = TextEditingController();
  String selectedStatus = '';

  final List<XFile> _images = [];

  Future<void> _getImages() async {
    // try {
    final List<XFile> pickedFiles = await ImagePicker().pickMultiImage(
      limit: widget.data.nBins[0] == 1
          ? widget.data.nBins[0] + 1
          : widget.data.nBins[0],
      imageQuality: 60,
    );
    setState(() {
      _images.addAll(pickedFiles);
    });
    // } catch (e) {
    //   print("Error: $e");
    // }
  }

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.data.status;
    _nBinsController.text = widget.data.nBins[0].toString();
    _noteController.text = widget.data.notes;
    _materialController.text = widget.data.materials.join(', ');
  }

  @override
  Widget build(BuildContext context) {
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
              TitleActionChild(
                title: 'Notes',
                titlePadding: const EdgeInsets.only(
                  bottom: 10.0,
                ),
                child: CustomTextField2(
                  hintText: _noteController.text,
                  controller: _noteController,
                  prefixIcon: const Icon(
                    Icons.description_outlined,
                  ),
                  // isReadOnly: true,
                ),
              ),
              Gaps.verticalGapOf(
                16.0,
              ),
              TitleActionChild(
                title: 'nBins',
                titlePadding: const EdgeInsets.only(
                  bottom: 10.0,
                ),
                child: CustomTextField2(
                  hintText: _nBinsController.text,
                  controller: _nBinsController,
                  prefixIcon: const Icon(
                    Icons.water_damage_outlined,
                  ),
                  // isReadOnly: true,
                ),
              ),
              Gaps.verticalGapOf(
                16.0,
              ),
              // TitleActionChild(
              //   title: 'Material',
              //   titlePadding: const EdgeInsets.only(
              //     bottom: 10.0,
              //   ),
              //   child: CustomTextField2(
              //     hintText: _materialController.text,
              //     controller: _materialController,
              //     prefixIcon: const Icon(
              //       Icons.inventory_2_outlined,
              //     ),
              //     // isReadOnly: true,
              //   ),
              // ),
              // Gaps.verticalGapOf(
              //   16.0,
              // ),
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
                      crossAxisCount: 3,
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
              if (_images.isEmpty || widget.data.nBins != _images.length)
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

              CustomDropdown(
                selectedValue: selectedStatus,
                items: AppConstants.getPickupStatusList,
                label: '',
                onChanged: (value) {
                  setState(
                    () {
                      selectedStatus = value;
                    },
                  );
                },
              ),
              Gaps.verticalGapOf(30),
              CustomMaterialButton(
                label: 'Submit',
                onTap: () {
                  var updateProvider = context.read<ProutesDetailProvider>();

                  // var attachmentwithIndex = _images
                  //     .asMap()
                  //     .map((key, value) => MapEntry(key.toString(), value.path));

                  Map<String, dynamic> body = {
                    "status": selectedStatus,
                    "ended_at": DateUtility.formatDateTime(
                      endTime,
                    ),
                    "notes": _noteController.text.toString(),
                    "n_bins": _nBinsController.text,
                    // "materials": _materialController.text
                    // if (attachmentwithIndex.isNotEmpty) ...{
                    //   for (var entry in attachmentwithIndex.entries) ...{
                    //     'attachment[${entry.key}]': entry.value
                    //   }
                    // }
                  };

                  print('body $body');
                  updateProvider.updatePickup(
                    context,
                    body,
                    widget.data.id,
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
