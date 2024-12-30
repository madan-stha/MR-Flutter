import 'package:smc_flutter/src/src.dart';

class BottomNavModel {
  String title;
  String icon;

  BottomNavModel({
    required this.title,
    required this.icon,
  });
}

List<BottomNavModel> bottomNavList = [
  BottomNavModel(
    title: AppString.home,
    icon: Assets.home,
  ),
  BottomNavModel(
    title: AppString.order,
    icon: Assets.order,
  ),
  BottomNavModel(
    title: AppString.profile,
    icon: Assets.profile,
  ),
];
