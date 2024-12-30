import 'package:flutter/material.dart';
import 'package:smc_flutter/src/src.dart';

class TwoFaCard extends StatefulWidget {
  final TwoFaModel datas;
  final int id;
  const TwoFaCard({super.key, required this.datas, required this.id});

  @override
  State<TwoFaCard> createState() => _TwoFaCardState();
}

class _TwoFaCardState extends State<TwoFaCard> {
  @override
  Widget build(BuildContext context) {
    print("widget.datas---> ${widget.datas.qrCodeUrl}");
    return Scaffold(
      appBar: CustomAppBar(
        title: AppString.lblTwoFaAuthentication,
        bgColor: AppColors.white,
        titleColor: AppColors.kPitchBlackColor,
        radius: false,
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(
            Dimensions.radiusDefault,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault,
          vertical: Dimensions.paddingSizeDefault,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gaps.verticalGapOf(
              20.0,
            ),
            Text(
              AppString.lbl2FaQrInformation,
              style: AppStyles.text14PxRegular,
              textAlign: TextAlign.center,
            ),
            Gaps.verticalGapOf(
              30.0,
            ),
            SvgHelper.fromSource(
              path: widget.datas.qrCodeUrl,
              type: SvgSourceType.network,
              height: 200,
              width: 200,
            ),
            Gaps.verticalGapOf(
              30.0,
            ),
            Text(
              AppString.lbl2FaQrNotScan,
              style: AppStyles.text14PxRegular,
              textAlign: TextAlign.center,
            ),
            Gaps.verticalGapOf(
              30.0,
            ),
            Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault,
                ),
                decoration: BoxDecoration(
                  color: AppColors.greyColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(
                    Dimensions.radiusDefault,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.datas.secretKey,
                      style: AppStyles.text14PxMedium,
                    ),
                    CustomTextButton(
                      onPressed: () => Utility.copyTextToClipboard(
                        widget.datas.secretKey,
                      ),
                      text: 'Copy',
                      padding: EdgeInsets.zero,
                    ),
                  ],
                )),
            const Spacer(),
            Text(
              AppString.lbl2FaInformation,
              style: AppStyles.text12PxRegular.copyWith(
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            Gaps.verticalGapOf(16.0),
            CustomMaterialButton(
              label: AppString.lblEnterConfirmationCode,
              elevation: 0,
              onTap: () {
                Utility.navigateMaterialRoute(
                  context,
                const    VerificationScreen(
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
