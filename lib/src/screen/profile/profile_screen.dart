import 'package:flutter/material.dart';

import '../../src.dart';

class ProfileScreen extends StatelessWidget {
  final UserModel data;
  const ProfileScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    print('Profile Image ${data.toJson()}');
    return Scaffold(
      appBar: CustomAppBar(
        title: data.name.capitalize(),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeDefault,
                vertical: Dimensions.paddingSizeDefault,
              ),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeSmall,
                vertical: Dimensions.paddingSizeSmall,
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(
                  Dimensions.radiusDefault,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  customInkwell(
                    onTap: () => Utility.navigateMaterialRoute(
                      context,
                      Hero(
                        tag: "profile",
                        child: CustomPhotoViewer(
                          imageUrls: [data.image],
                          initialIndex: 0,
                        ),
                      ),
                    ),
                    child: CustomImage(
                      data.image,
                      imageType: CustomImageType.network,
                      height: 110,
                      border: true,
                      borderColor: AppColors.white,
                      width: 110,
                      borderRadius: 12,
                    ),
                  ),
                  Gaps.verticalGapOf(10),
                  Text(
                    data.name.capitalize(),
                    style: AppStyles.text16PxMedium,
                  ),
                  Text(
                    data.email,
                    style: AppStyles.text12PxRegular,
                  ),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault,
                  vertical: Dimensions.paddingSizeExtraSmall,
                ),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeSmall,
                  vertical: Dimensions.paddingSizeSmall,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(
                    Dimensions.radiusDefault,
                  ),
                ),
                child: TitleActionChild(
                  title: 'Contact Information',
                  titleStyle: AppStyles.text14PxMedium,
                  titlePadding: const EdgeInsets.only(
                    bottom: Dimensions.paddingSizeSmall,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      if (Utility.isAccessible(data.email))
                        ProfileReusableWidget().iconValue(
                          icon: Assets.email,
                          title: data.email,
                          value: '',
                        ),
                      if (Utility.isAccessible(data.email))
                        Gaps.verticalGapOf(
                          10,
                        ),
                      if (Utility.isAccessible(data.phoneNumber))
                        ProfileReusableWidget().iconValue(
                          icon: Assets.phone,
                          title: data.phoneNumber,
                          value: '',
                        ),
                      if (Utility.isAccessible(data.phoneNumber))
                        Gaps.verticalGapOf(
                          10,
                        ),
                      if (Utility.isAccessible(data.city) ||
                          Utility.isAccessible(data.state) ||
                          Utility.isAccessible(data.country))
                        buildLocationWidget(data),
                      if (Utility.isAccessible(data.city))
                        Gaps.verticalGapOf(
                          10,
                        ),
                      if (Utility.isAccessible(data.zipCode))
                        ProfileReusableWidget().iconValue(
                          icon: Assets.zipCode,
                          title: data.zipCode,
                          value: '',
                        ),
                      if (Utility.isAccessible(data.zipCode))
                        Gaps.verticalGapOf(
                          10,
                        ),
                      if (Utility.isAccessible(data.language))
                        ProfileReusableWidget().iconValue(
                          icon: Assets.language,
                          title: Utility.getLanguageFromCode(
                            data.language,
                          ),
                          value: '',
                        ),
                    ],
                  ),
                )),

            //! Branch Container
            Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault,
                  vertical: Dimensions.paddingSizeExtraSmall,
                ),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeSmall,
                  vertical: Dimensions.paddingSizeSmall,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(
                    Dimensions.radiusDefault,
                  ),
                ),
                child: TitleActionChild(
                  title: 'Branch Name: ${data.branch!.branchName} ',
                  titleStyle: AppStyles.text14PxMedium,
                  titlePadding: const EdgeInsets.only(
                    bottom: Dimensions.paddingSizeSmall,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      if (Utility.isAccessible(data.branch!.branchEmail))
                        ProfileReusableWidget().iconValue(
                          icon: Assets.email,
                          title: data.branch!.branchEmail,
                          value: '',
                        ),
                      if (Utility.isAccessible(data.branch!.branchEmail))
                        Gaps.verticalGapOf(
                          10,
                        ),
                      if (Utility.isAccessible(data.branch!.branchPhone))
                        ProfileReusableWidget().iconValue(
                          icon: Assets.phone,
                          title: data.branch!.branchPhone,
                          value: '',
                        ),
                      if (Utility.isAccessible(data.branch!.branchPhone))
                        Gaps.verticalGapOf(
                          10,
                        ),
                      if (Utility.isAccessible(data.branch!.branchCity) ||
                          Utility.isAccessible(data.branch!.branchState) ||
                          Utility.isAccessible(data.branch!.branchCountry))
                        buildBranchLocationWidget(data),
                      if (Utility.isAccessible(data.branch!.branchCity))
                        Gaps.verticalGapOf(
                          10,
                        ),
                      if (Utility.isAccessible(data.branch!.branchZip))
                        ProfileReusableWidget().iconValue(
                          icon: Assets.zipCode,
                          title: data.branch!.branchZip,
                          value: '',
                        ),
                      if (Utility.isAccessible(data.branch!.branchZip))
                        Gaps.verticalGapOf(
                          10,
                        ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget buildLocationWidget(data) {
    if (!Utility.isAccessible(data.city)) {
      return const SizedBox.shrink();
    }

    String locationText = '';

    if (Utility.isAccessible(data.city)) {
      locationText += data.city;
    }
    if (Utility.isAccessible(data.state)) {
      if (locationText.isNotEmpty) locationText += ', ';
      locationText += data.state;
    }
    if (Utility.isAccessible(data.country)) {
      if (locationText.isNotEmpty) locationText += ', ';
      locationText += data.country;
    }

    return ProfileReusableWidget().iconValue(
      icon: Assets.location,
      title: locationText,
    );
  }

  Widget buildBranchLocationWidget(data) {
    if (!Utility.isAccessible(data.branch.branchCity)) {
      return const SizedBox.shrink();
    }

    String locationText = '';

    if (Utility.isAccessible(data.branch!.branchCity)) {
      locationText += data.branch!.branchCity;
    }
    if (Utility.isAccessible(data.branch!.branchState)) {
      if (locationText.isNotEmpty) locationText += ', ';
      locationText += data.branch!.branchState;
    }
    if (Utility.isAccessible(data.branch!.branchCountry)) {
      if (locationText.isNotEmpty) locationText += ', ';
      locationText += data.branch!.branchCountry;
    }

    return ProfileReusableWidget().iconValue(
      icon: Assets.location,
      title: locationText,
    );
  }
}
