import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smc_flutter/src/src.dart';

class PickupOrderCard extends StatefulWidget {
  const PickupOrderCard({super.key});

  @override
  State<PickupOrderCard> createState() => _PickupOrderCardState();
}

class _PickupOrderCardState extends State<PickupOrderCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Consumer<PickUpProvider>(builder: (context, state, _) {
                  return ListView.builder(
                      itemCount: state.pickUpRoutes.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            CompletedCardTask(),
                            PendingCardTask(),
                            CompletedCardTask()
                          ],
                        );
                      });
                }))));
  }
}

Widget CompletedCardTask() {
  return Card(
    color: Colors.white,
    clipBehavior: Clip.hardEdge,
    child: InkWell(
      splashColor: Colors.blue.withAlpha(30),
      onTap: () {
        debugPrint('Card tapped.');
      },
      child: SizedBox(
        width: 342,
        height: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardTaskDetails('Task #1229', 'Monday, 23rd April',
                'Sid and 4oth..', '140Kilos'),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  CustomMaterialButton(
                    label: 'Completed',

                    height: 22,
                    width: 113,
                    fillButton: false,
                    icon: Assets.tickcircle,
                    iconType: 'svg',
                    smallbutton: true,
                    showBorder: true,
                    // icon: Icon(Icons.airplane_ticket),
                  ),
                  Gaps.horizontalGapOf(20),
                  Row(
                    children: [
                      CustomTextButton(
                          text: 'Details',
                          textStyle: AppStyles.text12PxRegular,
                          onPressed: () {}),
                      const Icon(Icons.arrow_forward)
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget PendingCardTask() {
  return Card(
    color: Colors.white,
    clipBehavior: Clip.hardEdge,
    child: InkWell(
      splashColor: Colors.blue.withAlpha(30),
      onTap: () {
        debugPrint('Card tapped.');
      },
      child: SizedBox(
        width: 342,
        height: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardTaskDetails('Task #1229', 'Monday, 23rd April',
                'Sid and 4oth..', '140Kilos'),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  CustomMaterialButton(
                    label: 'Pending',

                    height: 22,
                    width: 113,
                    fillButton: false,
                    icon: Assets.tickcircle,
                    iconType: 'svg',
                    smallbutton: true,
                    showBorder: true,
                    // icon: Icon(Icons.airplane_ticket),
                  ),
                  Gaps.horizontalGapOf(20),
                  Row(
                    children: [
                      CustomTextButton(
                          text: 'Details',
                          textStyle: AppStyles.text12PxRegular,
                          onPressed: () {}),
                      const Icon(Icons.arrow_forward)
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget CardTaskDetails(String title, String date, String user, String weight) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyles.text16PxRegular
              .copyWith(color: AppColors.kPitchBlackColor),
        ),
        Gaps.verticalGapOf(10),
        Row(
          children: [
            Row(
              children: [
                const Icon(Icons.watch_later_outlined),
                Gaps.horizontalGapOf(5),
                Text(
                  date,
                  style: AppStyles.text12PxRegular
                      .copyWith(color: AppColors.kPitchBlackColor),
                ),
              ],
            ),
            Gaps.horizontalGapOf(20),
            Row(
              children: [
                const Icon(Icons.person_outline),
                Gaps.horizontalGapOf(5),
                Text(
                  user,
                  style: AppStyles.text12PxRegular
                      .copyWith(color: AppColors.kPitchBlackColor),
                ),
              ],
            ),
          ],
        ),
        Gaps.verticalGapOf(10),
        Row(
          children: [
            const Icon(Icons.fire_truck_outlined),
            Gaps.horizontalGapOf(5),
            Text(
              weight,
              style: AppStyles.text12PxRegular
                  .copyWith(color: AppColors.kPitchBlackColor),
            )
          ],
        ),
      ],
    ),
  );
}
