import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smc_flutter/src/src.dart';

class PickUpScreen extends StatefulWidget {
  const PickUpScreen({super.key});

  @override
  State<PickUpScreen> createState() => _PickUpScreenState();
}

class _PickUpScreenState extends State<PickUpScreen> {
  String currentAddress = '';

  @override
  void initState() {
    super.initState();
    context.read<PickUpProvider>().fetchData();
    // fetchAddresses();
  }

  Future<String> fetchAddressForSingleCustomer(coordinates) async {
    try {
      var address = await LocationUtility.getAddress(
        coordinates[0],
        coordinates[1],
      );
      return address;
    } catch (e) {
      print('Error fetching address: $e');
      return 'Address not found';
    }
  }

  @override
  Widget build(BuildContext context) {
    print('currentAddress $currentAddress');
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<PickUpProvider>(
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
              return (!Utility.isAccessible(state.pickUpRoutes) ||
                      state.pickUpRoutes.isEmpty)
                  ? const NoDataFoundScreen()
                  : ListView.builder(
                      itemCount: state.pickUpRoutes.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var data = state.pickUpRoutes[index];
                        if (data.customers.length > 1) {
                          if (data.customers.length == 1) {
                            fetchAddressForSingleCustomer(data.coordinates[0])
                                .then((address) {
                              setState(() {
                                currentAddress = address;
                              });
                            });
                          }
                        }
                        return PickupCard(
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
