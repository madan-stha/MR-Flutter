import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smc_flutter/src/src.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  var user;

  @override
  void initState() {
    super.initState();
    context.read<UserProvider>().fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            AppString.profile,
            style: AppStyles.text16PxMedium.copyWith(
              color: AppColors.white,
            ),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: AppColors.kPrimaryColor,
        ),
        body: Consumer<UserProvider>(
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
              var data = state.user;

              return !Utility.isAccessible(data)
                  ? const NoDataFoundScreen()
                  : SingleChildScrollView(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Column(
                            children: <Widget>[
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(36),
                                    bottomRight: Radius.circular(35),
                                  ),
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Gaps.verticalGapOf(25),
                                    ProfileCard(
                                      name: data!.name.capitalize(),
                                      userName: data.email,
                                      imagePath: AppConstants.profileImage,
                                      data: data,
                                    ),
                                  ],
                                ),
                              ),
                              Gaps.verticalGapOf(20),
                              Column(
                                children: [
                                  Text(
                                    AppConstants.appVersion,
                                    style: AppStyles.text10PxRegular,
                                  ),
                                  Text(
                                    "Powered by IPP Technologies",
                                    style: AppStyles.text10PxRegular,
                                  )
                                ],
                              ),
                              Gaps.verticalGapOf(40),
                            ],
                          ),
                          Positioned(
                            top: 25.0,
                            child: Stack(
                              children: [
                                customInkwell(
                                  onTap: () => Utility.navigateMaterialRoute(
                                    context,
                                    CustomPhotoViewer(
                                      imageUrls: [data.image],
                                      initialIndex: 0,
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
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    height: 28,
                                    width: 28,
                                    decoration: BoxDecoration(
                                      color: AppColors.kPrimaryColor,
                                      border: Border.all(
                                        color: Theme.of(context).canvasColor,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    padding: const EdgeInsets.all(
                                      Dimensions.paddingSizeExtraSmall,
                                    ),
                                    child: SvgHelper.fromSource(
                                      path: Assets.edit,
                                      type: SvgSourceType.asset,
                                      color: Theme.of(context).canvasColor,
                                      height: 8,
                                      width: 8,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
            }
          },
        ));
  }
}

class ProfileCard extends StatelessWidget {
  final String name;
  final String? imagePath;
  final String userName;
  final data;

  ProfileCard({
    super.key,
    required this.name,
    required this.userName,
    this.imagePath,
    this.data,
  });

  // List of items for the dynamic list
  final List<Map<String, dynamic>> profileItems = [
    {
      'title': 'Settings',
      'subtitle': 'Change Password, Language & More',
      'icon': Assets.setting,
      'route': '/settings-screen',
    },
    {
      'title': 'About App',
      'subtitle': 'Rate Us, Share, About',
      'icon': Assets.info,
      'route': '/about',
    },
    {
      'title': 'Help',
      'subtitle': 'Help Center, Privacy, T&C',
      'icon': Assets.help,
      'route': '/help',
    },
    {
      'title': 'Logout',
      'subtitle': 'Logout your account.',
      'icon': Assets.logout,
      'route': '/logout',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gaps.verticalGapOf(40),
        Text(
          name,
          style: AppStyles.text16PxMedium.copyWith(
            color: AppColors.kPitchBlackColor,
          ),
        ),
        Text(
          userName,
          style: AppStyles.text12PxRegular.copyWith(
            color: AppColors.kPitchBlackColor,
          ),
        ),
        Gaps.verticalGapOf(10),

        // Tab Buttons
        CustomMaterialButton(
          label: 'View Details',
          fillButton: false,
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
          color: AppColors.kPitchBlackColor,
          width: MediaQuery.of(context).size.width * 0.3,
          radius: 35,
          height: 30,
          elevation: 0,
          onTap: () => Utility.navigateMaterialRoute(
              context,
              ProfileScreen(
                data: data,
              )),
        ),
        Gaps.verticalGapOf(5),

        // Divider
        const Divider(
          color: AppColors.greySecondary,
          thickness: 0.5,
          indent: 20,
          endIndent: 20,
        ),
        Gaps.verticalGapOf(10),

        // all of the listTitles are displayed here
        Column(
          children: [
            for (final item in profileItems)
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    minLeadingWidth: 10,
                    title: Text(
                      item['title'],
                      style: AppStyles.text14PxMedium,
                    ),
                    leading: SvgHelper.fromSource(
                      path: item['icon'],
                      type: SvgSourceType.asset,
                      height: 22,
                      width: 22,
                    ),
                    subtitle: Text(
                      item['subtitle'],
                      style: AppStyles.text12PxRegular,
                    ),
                    onTap: () {
                      if (item['route'] == '/logout') {
                        DialogManager.confirmationDialog(
                          context,
                          icon: Assets.sadLogout,
                          title: AppString.logoutTitle,
                          description: AppString.sureLogout,
                          isLogOut: true,
                          onYesPressed: () {
                            Utility.logout();
                          },
                        );
                      } else if (item['route'] == '/settings-screen') {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SettingsScreen()));
                      } else if (item['route'] == '/help') {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ConfirmationScreen()));
                      }
                    },
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.greyColor,
                      size: 18,
                    ),
                  ),
                ),
              ),
            Gaps.verticalGapOf(10),
          ],
        ),
      ],
    );
  }
}
