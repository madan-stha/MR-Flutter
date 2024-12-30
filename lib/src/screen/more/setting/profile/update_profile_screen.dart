import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smc_flutter/src/src.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  File? imageFile;
  var user;
  @override
  void initState() {
    super.initState();
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    user = userProvider.user;

    // Set edit data
    fullNameController.text = user.name;
    emailController.text = user.email;
    contactNumberController.text = user.phoneNumber;
    cityController.text = user.city;
    stateController.text = user.state;
    countryController.text = user.country;
  }

  getImage(ImageSource imageType) async {
    XFile? pickedFile = await _picker.pickImage(
      source: imageType,
      maxWidth: 500,
      maxHeight: 500,
      imageQuality: 60,
    );
    if (pickedFile == null) {
      return null;
    } else {
      File tempFile = File(pickedFile.path);

      setState(
        () {
          imageFile = tempFile;
        },
      );
    }
    // if (!mounted) return;
    // Navigator.of(context).pop();
  }

  TextEditingController? _getControllerForField(int index) {
    switch (index) {
      case 0:
        return fullNameController;
      case 1:
        return emailController;
      case 2:
        return contactNumberController;
      case 3:
        return cityController;
      case 4:
        return stateController;
      case 5:
        return countryController;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Update Profile Details',
        centerTitle: true,
        isBackButtonExist: true,
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
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.all(
                      10.0,
                    ),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColors.kPrimaryColor, width: 5),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(100),
                      ),
                    ),
                    child: ClipOval(
                        child: imageFile != null
                            ? Image.file(
                                imageFile!,
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              )
                            : CustomImage(
                                user.image,
                                height: 120,
                                width: 120,
                              )),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 20,
                    child: InkWell(
                      onTap: () {
                        getImage(
                          ImageSource.gallery,
                        );
                      },
                      child: const CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColors.kPrimaryColor,
                        child: Icon(
                          Icons.add_a_photo_outlined,
                          size: 18,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Gaps.verticalGapOf(
                20.0,
              ),
              Column(
                children: List.generate(
                  updateProfileField.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: titleActionChild(
                      title: updateProfileField[index].label,
                      hintText: updateProfileField[index].hintText,
                      isNumberField: updateProfileField[index].isNumberField,
                      prefix: updateProfileField[index].prefix,
                      maxLines: updateProfileField[index].maxLines,
                      contentPadding: updateProfileField[index].contentPadding,
                      isReadOnly: updateProfileField[index].isReadOnly,
                      isLastItem: updateProfileField[index].isLastItem,
                      controller: _getControllerForField(index),
                    ),
                  ),
                ),
              ),
              Gaps.verticalGapOf(20),
              CustomMaterialButton(
                onTap: () {
                  var profileImage = imageFile != null
                      ? MultipartFile.fromBytes(
                          imageFile!.readAsBytesSync(),
                          filename: imageFile!.path.split('/').last,
                          contentType: MediaType(
                            'image',
                            'png',
                          ),
                        )
                      : null;

                  var requestBody = {
                    "name": fullNameController.text,
                    "email": emailController.text,
                    "phone_number": contactNumberController.text,
                    "city": cityController.text,
                    "state": stateController.text,
                    "country": countryController.text,
                    "image": profileImage
                  };
                  context
                      .read<UserProvider>()
                      .updateProfile(context, requestBody);
                },
                elevation: 0,
                label: "Update",
              ),
              Gaps.verticalGapOf(20),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleActionChild({
    required String title,
    required String hintText,
    Widget? prefix,
    TextEditingController? controller,
    int? maxLines,
    bool isNumberField = false,
    bool contentPadding = true,
    bool isReadOnly = false,
    isLastItem = false,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TitleActionChild(
          title: title,
          titleStyle: AppStyles.text14PxMedium,
          titlePadding: const EdgeInsets.only(
            bottom: Dimensions.paddingSizeEight,
          ),
          child: CustomTextField2(
            hintText: hintText,
            controller: controller,
            isNumberField: isNumberField,
            contentPadding: contentPadding,
            isReadOnly: isReadOnly,
            textInputAction:
                isLastItem ? TextInputAction.done : TextInputAction.next,
            maxLines: maxLines,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(
                Dimensions.paddingSizeDefault,
              ),
              child: prefix,
            ),
          ),
        ),
      ],
    );
  }
}
