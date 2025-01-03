import 'package:flutter/material.dart';
import 'package:smc_flutter/src/src.dart';

class ProfileReusableWidget {
  iconValue(
      {icon,
      String? title,
      String? value,
      Color? color,
      double size = 14,
      bool isBold = false,
      String iconType = "svg",
      bool isIconContainer = true}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        iconType == "svg"
            ? isIconContainer
                ? Container(
                    height: 26,
                    width: 26,
                    padding: const EdgeInsets.all(
                      Dimensions.paddingSizeExtraSmall,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.kPrimaryColor.withOpacity(0.1),
                    ),
                    child: SvgHelper.fromSource(
                      path: icon ?? "",
                      height: size,
                      width: size,
                    ),
                  )
                : SvgHelper.fromSource(
                    path: icon ?? "",
                    height: size,
                    width: size,
                  )
            : Icon(
                icon,
                color: color,
                size: size,
              ),
        Gaps.horizontalGapOf(10),
        value != null
            ? Row(
                children: [
                  Text(
                    title ?? 'N/A',
                    overflow: TextOverflow.ellipsis,
                    style: isBold
                        ? AppStyles.text12PxMedium
                        : AppStyles.text12PxRegular,
                  ),
                  Text(
                    value,
                    style: AppStyles.text12PxRegular,
                  ),
                ],
              )
            : Expanded(
                child: Text(
                  title ?? 'N/A',
                  overflow: TextOverflow.ellipsis,
                  style: isBold
                      ? AppStyles.text12PxMedium
                      : AppStyles.text12PxRegular,
                ),
              ),
      ],
    );
  }

  roundedIcon(context, {value, icon, onTap}) {
    return customInkwell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(Dimensions.radiusExtraMoreLarge),
        ),
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Icon(
          icon ?? Icons.phone_outlined,
          size: 20,
          color: AppColors.white,
        ),
      ),
    );
  }

  commonTextRender(String? title, String? value,
      {TextStyle? style, TextStyle? style2, onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            title ?? '',
            style: style ??
                AppStyles.text12PxRegular.copyWith(
                  color: AppColors.kPitchBlackColor.withOpacity(
                    0.9,
                  ),
                ),
          ),
        ),
        Expanded(
          flex: 3,
          child: customInkwell(
            onTap: onTap ?? () {},
            child: Text(
              value ?? '',
              style: style2 ??
                  AppStyles.text12PxMedium.copyWith(
                    color: AppColors.kPitchBlackColor,
                  ),
              textAlign: TextAlign.end,
            ),
          ),
        ),
      ],
    );
  }

  static buildSmallProductPreview(context, List<String> images, int index) {
    return GestureDetector(
      onTap: () => Utility.navigateMaterialRoute(
        context,
        CustomPhotoViewer(
          imageUrls: images,
          initialIndex: index,
        ),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(right: 15),
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: AppColors.kPrimaryColor,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            images[index],
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => ClipRRect(
              borderRadius: BorderRadius.circular(
                Dimensions.radiusSmall,
              ),
              child: Image.asset(
                Assets.placeholder,
                height: 20,
                width: 20,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  iconValueColumn({icon, iconColor, String? title, String? value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? '',
          style: AppStyles.text10PxRegular.copyWith(
            color: AppColors.greyColor,
          ),
        ),
        Gaps.verticalGapOf(5),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.location_on,
              size: 16,
              color: iconColor ?? AppColors.kPitchBlackColor,
            ),
            Gaps.horizontalGapOf(8),
            Text(
              value ?? '',
              style: AppStyles.text12PxRegular,
            ),
          ],
        ),
      ],
    );
  }
}

class ProfileReusableForm {
  customerData({
    String? customername,
    String? number,
    List<String> coordinates = const [],
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Customer Name',
              style: AppStyles.text14PxRegular,
            ),
            Expanded(
              child: Text(
                customername ?? '',
                style: AppStyles.text14PxSemiBold,
                textAlign: TextAlign.end, // Align the text to the end
              ),
            ),
          ],
        ),
        Gaps.verticalGapOf(10),
        Row(
          children: [
            Text(
              'Number of Items',
              style: AppStyles.text14PxRegular,
            ),
            Expanded(
              child: Text(
                number ?? '', // Ensure number is not null
                style: AppStyles.text14PxSemiBold,
                textAlign: TextAlign.end, // Align the text to the end
              ),
            ),
          ],
        ),
        Gaps.verticalGapOf(10),
        Row(
          children: [
            Text(
              'Address',
              style: AppStyles.text14PxRegular,
            ),
            Expanded(
              child: Text(
                coordinates.toString(),
                style: AppStyles.text14PxSemiBold,
                textAlign: TextAlign.end, // Align the text to the end
              ),
            ),
          ],
        ),
      ],
    );
  }
}
