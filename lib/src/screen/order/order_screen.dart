import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:smc_flutter/src/src.dart';

class OrderScreen extends StatelessWidget {
  final bool backButtonExist;
  const OrderScreen({super.key, this.backButtonExist = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppString.order,
        centerTitle: true,
        isBackButtonExist: backButtonExist,
        showCart: true,
        isNotification: !backButtonExist,
      ),
      body: const ChoiceChipWidget(),
    );
  }
}

class ChoiceChipWidget extends StatefulWidget {
  const ChoiceChipWidget({super.key});

  @override
  State<ChoiceChipWidget> createState() => _ChoiceChipWidgetState();
}

class _ChoiceChipWidgetState extends State<ChoiceChipWidget>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController =
        TabController(length: AppConstants.tabList.length, vsync: this);
    super.initState();
    context.read<PickUpProvider>().fetchData();
    context.read<DeliveryProvider>().fetchData();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Gaps.verticalGapOf(10),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault,
              vertical: Dimensions.paddingSizeEight,
            ),
            child: TabBar(
              controller: _tabController,
              dividerColor: AppColors.transparent,
              indicator: const BoxDecoration(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(Dimensions.radiusLarge),
                  right: Radius.circular(
                    Dimensions.radiusLarge,
                  ),
                ),
                color: AppColors.kPrimaryColor,
              ),
              unselectedLabelColor: AppColors.kPitchBlackColor,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: AppColors.white,
              labelStyle: AppStyles.text16PxMedium,
              unselectedLabelStyle: AppStyles.text16PxRegular,
              tabs: AppConstants.tabList
                  .map(
                    (e) => Tab(
                      text: e,
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                  )
                  .toList(),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                PickUpScreen(),
                DeliveryScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
