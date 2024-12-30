import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smc_flutter/src/src.dart';

class DeliveryScreen extends StatefulWidget {
  final bool isCurrent;
  const DeliveryScreen({
    super.key,
    this.isCurrent = false,
  });

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  String currentAddress = '';

  @override
  void initState() {
    super.initState();
    context.read<DeliveryProvider>().fetchData();
    fetchCurrentLocation();
  }

  fetchCurrentLocation() async {
    var provider = context.read<DeliveryProvider>().deliveryData;
    // ignore: unnecessary_null_comparison
    var coordinatesIndex = provider.indexWhere((e) => e.coordinate != null);

    if (coordinatesIndex != -1) {
      var coordinates = provider[coordinatesIndex].coordinate;
      var address = await LocationUtility.getAddress(
        coordinates[0],
        coordinates[1],
      );
      setState(() {
        currentAddress = address;
      });
    } else {
      setState(() {
        currentAddress = "No coordinates found";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('currentAddress $currentAddress');
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Consumer<DeliveryProvider>(
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
              return !Utility.isAccessible(state.deliveryData)
                  ? const NoDataFoundScreen()
                  : ListView.builder(
                      itemCount: widget.isCurrent
                          ? state.deliveryData.length >= 5
                              ? 5
                              : state.deliveryData.length
                          : state.deliveryData.length,
                      shrinkWrap: true,
                      controller: ScrollController(),
                      physics: widget.isCurrent
                          ? const BouncingScrollPhysics()
                          : const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        var data = state.deliveryData[index];
                        return DeliveryCard(
                          data: data,
                          currentAddress: currentAddress,
                        );
                      },
                    );
            }
          },
        ),
      ),
    );
  }
}
