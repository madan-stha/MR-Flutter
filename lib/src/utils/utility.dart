import 'dart:ui' as ui;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smc_flutter/src/src.dart';

import '../../navigator_key.dart';

class Utility {
  // Navigate through routes
  static Future navigate(BuildContext context, String route,
      {dynamic arguments}) {
    return Navigator.of(context).pushNamed(
      route,
      arguments: arguments,
    );
  }

// Navigates through screen
  static navigateMaterialRoute(BuildContext context, screen) {
    print('screenNavigatedTo---> $screen');
    return Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          var tween = Tween<Offset>(begin: begin, end: end);

          var curveTween = CurveTween(curve: Curves.ease);

          return SlideTransition(
            position: animation.drive(curveTween).drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  static handleSessionExpired() {
    var context = navigatorKey.currentContext as BuildContext;

    return DialogManager.customDialog(
      context,
      title: AppString.sessionExpired,
      description: AppString.sessionExpiredMessage,
      isDismissible: false,
      image: Assets.sessionExpired,
      action: CustomMaterialButton(
        label: 'Ok, logout',
        onTap: () {
          Utility.logout(isSessionExpired: true);
        },
        elevation: 0,
        radius: 30,
        height: 40,
      ),
    );
  }

  static getIndexAlpha(index) {
    int alphabetIndex = index + 65;

    return String.fromCharCode(alphabetIndex);
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  horizonDivider(String title, {color, textStyle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            indent: 20.0,
            endIndent: 10.0,
            thickness: 1,
            color: color,
          ),
        ),
        Text(
          title,
          style: textStyle ?? AppStyles.text14PxRegular,
        ),
        Expanded(
          child: Divider(
            indent: 10.0,
            endIndent: 20.0,
            thickness: 1,
            color: color,
          ),
        ),
      ],
    );
  }

  static bool isAccessible(data) {
    bool isEmpty = true;
    try {
      if (data != null) {
        if (data is int) {
          return isEmpty;
        }
        if (data?.isEmpty) {
          isEmpty = false;
        }
      } else {
        isEmpty = false;
      }
      return isEmpty;
    } catch (e) {
      return isEmpty;
    }
  }

  static bool isNotEmpty(String? value) {
    return value != null && value.isNotEmpty;
  }

  static getLanguageFromCode(String code) {
    return code == 'en' ? 'English' : 'Other';
  }

  static logout({bool isSessionExpired = false}) async {
    try {
      var context = navigatorKey.currentContext as BuildContext;
      DialogManager.showModalDialouge(
        context,
        null,
        true,
        {
          'text': 'Logging out...',
        },
      );

      HttpRepo httpRepo = HttpServices();
      await SharedPreferencesService().deleteSharedPref('logged');
      if (!isSessionExpired) {
        var response =
            await httpRepo.post(ApiConstant.logoutUri, {}, requiresToken: true);
        print('response---> ${response.data}');
        print('mrres---> ${response.message}');
      }

      await SharedPreferencesService().deleteSharedPref('userData');

      Navigator.of(context).pop();
      Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (_) => false,
      );
    } catch (e) {}
  }

  static Duration getDuration(ToastLength? toastLength) {
    switch (toastLength) {
      case ToastLength.short:
        return const Duration(seconds: 2);
      case ToastLength.long:
        return const Duration(seconds: 5);
      default:
        return const Duration(seconds: 2);
    }
  }

  static Future<String> onGetFCMToken() async {
    FirebaseMessaging messaging;
    messaging = FirebaseMessaging.instance;

    try {
      final token = await messaging.getToken();
      print('FCM' + token!);
      return token!;
    } catch (e) {
      print('FCM');
      print(e.toString());
      return '';
    }
  }

  static copyTextToClipboard(String text) {
    Clipboard.setData(
      ClipboardData(
        text: text,
      ),
    );
    return Fluttertoast.showToast(
      msg: 'Copied to clipboard',
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'placed':
      case 'in_progress':
      case 'ongoing':
        return AppColors.blueColor;

      case 'awaiting pickup':
        return AppColors.pendingColor;
      case 'picked up':
      case 'in transit':
        return AppColors.purpleColor;
      case 'pickup':
      case 'delivery':
      case 'completed':
      case 'active':
      case 'full':
      case 'done':
        return AppColors.successColor;
      case 'out for delivery':
        return AppColors.pendingColor;
      case 'delayed':
        return AppColors.rejectedColor;
      case 'delivered':
        return AppColors.successColor;
      case 'cancelled':
        return AppColors.warningColor;
      case 'lost':
        return AppColors.rejectedColor;
      case 'pending':
        return AppColors.pendingColor;
      default:
        return AppColors.blackColor;
    }
  }

  static String getStatus(String status) {
    switch (status.toLowerCase()) {
      case 'placed':
        return 'Placed';
      case 'pending':
        return 'Pending';
      case 'completed':
      case 'done':
        return 'Completed';
      case 'active':
      case 'in_progress':
        return 'On Going';
      case 'awaiting pickup':
        return 'Awaiting Pickup';
      case 'pickup':
        return 'Pick Up';
      case 'delivery':
        return 'Delivery';
      case 'in transit':
        return 'In Transit';
      case 'out for delivery':
        return 'Out for Delivery';
      case 'ongoing':
        return 'Ongoing';
      case 'delayed':
        return 'Delayed';
      case 'delivered':
        return 'Delivered';
      case 'cancelled':
        return 'Cancelled';
      case 'full':
        return 'Full';
      case 'lost':
        return 'Lost';
      default:
        return 'Unknown';
    }
  }

  static getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'placed':
        return Icons.check_circle_outline;
      case 'completed':
      case 'active':
      case 'done':
        return Icons.check_circle;
      case 'awaiting pickup':
      case 'in transit':
      case 'out for delivery':
      case 'ongoing':
      case 'in_progress':
        return Icons.directions_car;
      case 'delivery':
        return Icons.airport_shuttle_outlined;
      case 'pickup':
        return Icons.local_shipping_outlined;
      case 'delayed':
      case 'pending':
        return Icons.access_time;
      case 'delivered':
        return Icons.done_all;
      case 'cancelled':
      case 'lost':
        return Icons.cancel;
      case 'full':
        return Icons.event_busy;
      default:
        return Icons.help_outline;
    }
  }

  static String formatCustomerNames(List<String> customerNames) {
    if (customerNames.isEmpty) {
      return 'N/A';
    } else if (customerNames.length == 1) {
      return customerNames[0].split(' ')[0];
    } else {
      return '${customerNames[0].split(' ')[0]} & ${customerNames.length - 1} ${customerNames.length > 2 ? 'others' : 'other'}';
    }
  }
}
