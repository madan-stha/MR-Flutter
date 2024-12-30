import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../src.dart';

class TwoFAScreen extends StatefulWidget {
  const TwoFAScreen({super.key});

  @override
  State<TwoFAScreen> createState() => _TwoFAScreenState();
}

class _TwoFAScreenState extends State<TwoFAScreen> {
  var userProvider;

  @override
  void initState() {
    super.initState();
    context.read<UserProvider>().fetchData();
    userProvider = context.read<TwoFaProvider>();
  }

  List twoFaSteps = [
    AppString.twoFaStep1,
    AppString.twoFaStep2,
    AppString.twoFaStep3,
  ];

  @override
  Widget build(BuildContext context) {
    print("userProvider---> $userProvider");
    return Scaffold(
      appBar: CustomAppBar(
        title: AppString.lblEnable2FA,
        bgColor: AppColors.white,
        titleColor: AppColors.kPitchBlackColor,
        radius: false,
      ),
      body: Consumer<UserProvider>(
        builder: (context, user, _) {
          userProvider.fetchData(context, id: "${user.user!.id}");
          if (user.isLoading) {
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
            return Consumer<TwoFaProvider>(
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
                  var hasData = Utility.isAccessible(
                    state.twoFA,
                  );
                  return Container(
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
                      children: [
                        Gaps.verticalGapOf(
                          20.0,
                        ),
                        SvgHelper.fromSource(
                          path: Assets.twofa,
                          height: 200,
                          width: 200,
                        ),
                        Gaps.verticalGapOf(
                          30.0,
                        ),
                        Text(
                          AppString.lblSetup2FA,
                          style: AppStyles.text20PxMedium,
                        ),
                        Gaps.verticalGapOf(
                          30.0,
                        ),
                        ...twoFaSteps.map(
                          (e) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: Dimensions.paddingSizeSmall,
                              ),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "• $e",
                                  style: AppStyles.text14PxRegular.copyWith(
                                      color: AppColors.kPitchBlackColor),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            );
                          },
                        ),
                        const Spacer(),
                        CustomMaterialButton(
                          label: AppString.lblGetStarted,
                          elevation: 0,
                          onTap: () {
                            if (hasData) {
                              Utility.navigateMaterialRoute(
                                context,
                                TwoFaCard(
                                  datas: state.twoFA,
                                  id: user.user!.id,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
