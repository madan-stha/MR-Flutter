import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../src.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var homeProvider;

  @override
  void initState() {
    super.initState();
    homeProvider = context.read<HomeProvider>().fetchData();
    context.read<UserProvider>().fetchData();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer2<HomeProvider, UserProvider>(
            builder: (context, homeState, userState, _) {
          if (homeState.isLoading || userState.isLoading) {
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
            List<DashboardModel> currentTasks = homeState.dashboard
                .where((element) => element.status == AppConstants.active)
                .toList();
            List<DashboardModel> assignedTasks = homeState.dashboard
                .where((element) => element.status != AppConstants.active)
                .toList();
            print("currentTasks ${currentTasks.length}");
            print("assignedTasks----------- ${assignedTasks.length}");
            return Stack(
              children: [
                if (userState.user != null) buildProfileAppBar(userState.user!),
                Positioned(
                  top: 70,
                  left: 0,
                  right: 0,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        currentTasks.isEmpty
                            ? Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.22,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeDefault,
                                  vertical: Dimensions.paddingSizeEight,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    Dimensions.radiusDefault,
                                  ),
                                  color: AppColors.white,
                                ),
                                child: const Center(
                                  child: Text(
                                    'No Current Task Found',
                                  ),
                                ),
                              )
                            : SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.22,
                                child: ListView.builder(
                                  itemCount: currentTasks.length,
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return buildCurrentTask(
                                        currentTasks[index]);
                                  },
                                ),
                              ),
                        TitleActionChild(
                          title: 'Tasks Assigned',
                          titlePadding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 10.0,
                          ),
                          titleStyle: AppStyles.text16PxMedium,
                          subTitle: 'View All',
                          onTap: () => Utility.navigateMaterialRoute(
                            context,
                            const OrderScreen(
                              backButtonExist: true,
                            ),
                          ),
                          subTitleStyle: AppStyles.text16PxRegular.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                          child: assignedTasks.isEmpty
                              ? const NoDataFoundScreen(
                                  description: 'No Task Found',
                                )
                              : ListView.builder(
                                  itemCount: assignedTasks.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return buildAssignedTask(
                                        assignedTasks[index]);
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }

  Widget buildCurrentTask(DashboardModel currentData) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: HomeCard(data: currentData),
    );
  }

  Widget buildAssignedTask(DashboardModel assignedData) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: AssignedCard(data: assignedData),
    );
  }

  Widget buildProfileAppBar(UserModel data) {
    return Column(
      children: [
        Container(
          height: 60,
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault,
            vertical: Dimensions.paddingSizeExtraSmall,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  customInkwell(
                    onTap: () => Utility.navigateMaterialRoute(
                      context,
                      ProfileScreen(
                        data: data,
                      ),
                    ),
                    child: CustomImage(
                      data.image,
                      height: Dimensions.profileImageSize,
                      width: Dimensions.profileImageSize,
                      circular: true,
                    ),
                  ),
                  Gaps.horizontalGapOf(
                    18,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi, Welcome Back ',
                        style: AppStyles.text14PxRegular.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      Text(
                        data.name.capitalize(),
                        style: AppStyles.text16PxMedium.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                onPressed: () => Utility.navigate(
                  context,
                  '/notification-screen',
                ),
                icon: SvgHelper.fromSource(
                  path: Assets.notifications,
                  width: 24,
                  height: 24,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 80,
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault,
            vertical: Dimensions.paddingSizeExtraSmall,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(
                Dimensions.radiusExtraLarge,
              ),
              bottomRight: Radius.circular(
                Dimensions.radiusExtraLarge,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
