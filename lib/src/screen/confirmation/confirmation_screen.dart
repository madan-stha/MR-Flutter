import 'package:flutter/material.dart';
import 'package:smc_flutter/src/model/confirmation_model.dart';
import 'package:smc_flutter/src/screen/confirmation/upload_image_screen.dart';
import 'package:smc_flutter/src/src.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({super.key});

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  TextEditingController idController = TextEditingController();
  TextEditingController customernameController = TextEditingController();
  TextEditingController customercontactController = TextEditingController();
  TextEditingController customerlocationController = TextEditingController();

  TextEditingController? _getControllerForField(int index) {
    switch (index) {
      case 0:
        return idController;
      case 1:
        return customernameController;
      case 2:
        return customercontactController;
      case 3:
        return customerlocationController;

      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Confirmation',
        centerTitle: true,
        isNotification: false,
        isBackButtonExist: true,
      ),
      body: Column(
        children: [
          Column(
            children: List.generate(
              confirmationfield.length,
              (index) => Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: titleActionChild(
                  title: confirmationfield[index].label,
                  hintText: confirmationfield[index].hintText,
                  isNumberField: confirmationfield[index].isNumberField,
                  prefix: confirmationfield[index].prefix,
                  maxLines: confirmationfield[index].maxLines,
                  contentPadding: confirmationfield[index].contentPadding,
                  isReadOnly: confirmationfield[index].isReadOnly,
                  isLastItem: confirmationfield[index].isLastItem,
                  controller: _getControllerForField(index),
                ),
              ),
            ),
          ),
          Gaps.verticalGapOf(20),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: CustomMaterialButton(
              label: 'Next',
              elevation: 0,
              onTap: () => Utility.navigateMaterialRoute(
                  context, const UploadImageScreen()),
              isBorderPrimary: true,
            ),
          )
        ],
      ),
    );
  }
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
          onlyline: true,
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
