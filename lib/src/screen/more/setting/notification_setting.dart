import 'package:flutter/material.dart';
import 'package:smc_flutter/src/src.dart';

class MoreAlertScreen extends StatefulWidget {
  const MoreAlertScreen({super.key});

  @override
  State<MoreAlertScreen> createState() => _MoreAlertScreenState();
}

class _MoreAlertScreenState extends State<MoreAlertScreen> {
  bool generalNotificationValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Notification Settings',
        centerTitle: true,
        isBackButtonExist: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(
            Dimensions.radiusDefault,
          ),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault,
          vertical: Dimensions.paddingSizeDefault,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault,
          vertical: Dimensions.paddingSizeDefault,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TitleActionChild(
              title: 'General',
              titleStyle: AppStyles.text14PxMedium,
              titlePadding:
                  const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
              child: generalNotification("Receive Push Notifications"),
            ),
          ],
        ),
      ),
    );
  }

  Widget generalNotification(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppStyles.text12PxRegular,
        ),
        const SizedBox(width: 30),
        ToggleButton(
          value: generalNotificationValue,
          onChanged: (newValue) {
            setState(
              () {
                generalNotificationValue = newValue;
              },
            );
          },
        ),
      ],
    );
  }
}

class ToggleButton extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  const ToggleButton({super.key, required this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged?.call(!value);
      },
      child: Container(
        width: 55.0,
        height: 25.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: value ? AppColors.kPrimaryColor : Colors.grey[300],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Row(
            mainAxisAlignment:
                value ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 20.0,
                height: 20.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                // child: value
                //     ? const Icon(
                //         // Icons.check,
                //         color: Colors.green,
                //       )
                //     : const Icon(
                //         // Icons.close,
                //         color: Colors.grey,
                //       ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
