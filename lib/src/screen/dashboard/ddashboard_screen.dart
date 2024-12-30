import 'package:flutter/material.dart';
import 'package:smc_flutter/src/src.dart';

class DriverDashboardScreen extends StatefulWidget {
  const DriverDashboardScreen({super.key});

  @override
  State<DriverDashboardScreen> createState() => _DriverDashboardScreenState();
}

class _DriverDashboardScreenState extends State<DriverDashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    OrderScreen(),
    MoreScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool isPop) {
        if (_currentIndex == 0) {
          doubleTapTrigger();
        } else {
          setState(() {
            _currentIndex = 0;
          });
        }
      },
      child: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          currentIndex: _currentIndex,
          selectedLabelStyle: AppStyles.text12PxRegular.copyWith(
            color: AppColors.kPrimaryColor,
          ),
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          items: bottomNavList.map((item) {
            return iconText(
              item.icon,
              item.title,
              _currentIndex == bottomNavList.indexOf(item),
            );
          }).toList(),
        ),
      ),
    );
  }

  BottomNavigationBarItem iconText(icon, title, isActive) {
    var activeOrNot = isActive
        ? AppColors.kPrimaryColor
        : AppColors.kPitchBlackColor.withOpacity(0.6);

    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgHelper.fromSource(
              path: icon, height: 24, width: 24, color: activeOrNot),
          const SizedBox(
            height: 5,
          ),
          Text(
            title ?? "",
            style: AppStyles.text12PxRegular.copyWith(color: activeOrNot),
          )
        ],
      ),
      label: title ?? "",
    );
  }
}
