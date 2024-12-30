import 'package:flutter/material.dart';
import 'package:smc_flutter/src/src.dart';

class OnBoardingScreen extends StatefulWidget {
  final bool isRoleDriver;
  const OnBoardingScreen({super.key, required this.isRoleDriver});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final List<Widget> _driverOnBoardingPages = [
    _OnBoardingPage(
      title: "Know Your Route",
      description:
          "Get clear directions & real-time traffic updates for faster deliveries.",
      imagePath: Assets.dOnBoard1,
    ),
    _OnBoardingPage(
      title: "Track Your Impact",
      description:
          "See your environmental contribution & recycling progress in real-time.",
      imagePath: Assets.dOnBoard2,
    ),
    _OnBoardingPage(
      title: "Deliver with Ease",
      description:
          "Manage pickups & deliveries efficiently with all the info you need.",
      imagePath: Assets.dOnBoard3,
      isLastPage: true,
    ),
  ];

  final List<Widget> _customerOnBoardingPages = [
    _OnBoardingPage(
      title: "Effortless Ordering",
      description:
          "Easily place orders for pickups and deliveries with just a few taps",
      imagePath: Assets.cOnBoard1,
    ),
    _OnBoardingPage(
      title: "Flexible Scheduling",
      description:
          "Schedule pickups and deliveries at your convenience, for today or later.",
      imagePath: Assets.cOnBoard2,
    ),
    _OnBoardingPage(
      title: "Order History and Receipts",
      description:
          "Quickly access past orders and receipts to track your delivery history.",
      imagePath: Assets.cOnBoard3,
      isLastPage: true,
    ),
  ];
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  void _navigateToNext() {
    setState(() {
      _currentIndex++;
      _pageController.jumpToPage(_currentIndex);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var onBoardData =
        widget.isRoleDriver ? _driverOnBoardingPages : _customerOnBoardingPages;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            image: DecorationImage(
              image: AssetImage(Assets.pattern),
              fit: BoxFit.cover,
              opacity: 0.1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LinearProgressIndicator(
                value: (_currentIndex + 1) / onBoardData.length,
                backgroundColor: AppColors.backgroundcolor,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.kPrimaryColor,
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemCount: onBoardData.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: onBoardData[index],
                    );
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 27, vertical: 20),
                child: CustomMaterialButton(
                  label: _currentIndex == onBoardData.length - 1
                      ? "Get Started"
                      : "Next",
                  elevation: 0,
                  onTap: () => _currentIndex == onBoardData.length - 1
                      ? Utility.navigate(
                          context,
                          AppRoutes.dashboardScreen,
                        )
                      : _navigateToNext(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnBoardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final bool isLastPage;

  const _OnBoardingPage({
    required this.title,
    required this.description,
    required this.imagePath,
    this.isLastPage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isLastPage)
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Align(
              alignment: Alignment.topRight,
              child: CustomTextButton(
                text: 'Skip',
                textStyle: AppStyles.text14PxRegular.copyWith(
                  color: const Color(0xFF434343),
                ),
                onPressed: () {
                  Utility.navigate(
                    context,
                    AppRoutes.dashboardScreen,
                  );
                },
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: CustomImage(
            imagePath,
            imageType: CustomImageType.local,
            height: 290,
            width: 290,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          title,
          style:
              AppStyles.text20PxMedium.copyWith(color: const Color(0xFF434343)),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: SizedBox(
            height: 70,
            width: double.maxFinite,
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: AppStyles.text14PxRegular.copyWith(
                color: const Color(0xFF434343),
              ),
            ),
          ),
        )
      ],
    );
  }
}
