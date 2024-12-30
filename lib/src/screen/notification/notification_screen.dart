import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../src.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppString.notifications,
        actions: [
          CustomTextButton(
            text: 'Mark all as read',
            icon: Icons.done_all_outlined,
            textStyle: AppStyles.text14PxRegular.copyWith(
              color: AppColors.white,
            ),
            iconColor: AppColors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Consumer<NotificationProvider>(
          builder: (context, state, _) {
            if (state.isLoading) {
              return Center(
                child: CustomLoader(
                  child: CustomImage(
                    Assets.logo,
                    height: Dimensions.loaderSize,
                    width: Dimensions.loaderSize,
                    imageType: CustomImageType.local,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: state.notification.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var data = state.notification[index];
                  return NotificationCard(
                    data: data,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
