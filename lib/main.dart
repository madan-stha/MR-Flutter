import 'dart:io';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smc_flutter/src/src.dart';

import 'navigator_key.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides();
  final SharedPreferencesService sharedPref = SharedPreferencesService();


  await EasyLocalization.ensureInitialized();

  var data = await sharedPref.getStringPref('userData');
  bool logged = await sharedPref.getBoolPref('logged');
  print('logged---> $logged');
  print('data---> $data');
  print('locale--> ${LanguageProvider.supportedLanguages.map(
        (language) => Locale(language.languageCode),
      ).toList()}');

  runApp(
    EasyLocalization(
      supportedLocales: LanguageProvider.supportedLanguages
          .map(
            (language) => Locale(language.languageCode),
          )
          .toList(),
      path: AppConstants.languagePath,
      fallbackLocale: const Locale(GlobalConfig.defaultLang),
      startLocale: const Locale(GlobalConfig.defaultLang),
      useOnlyLangCode: true,
      child: MainApp(
        data: data,
        logged: logged,
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  final bool logged;
  final data;
  const MainApp({super.key, required this.logged, this.data});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppProvider.providers,
      child: MyApp(
        logged: logged,
        data: data,
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  final bool logged;
  final data;
  const MyApp({super.key, required this.logged, this.data});

  @override
  Widget build(BuildContext context) {
    // Provider.of<LocationProvider>(context, listen: false).getUserLocation();

    LocationHelper.checkPermission(context);

    var isDarkTheme = Provider.of<ThemeProvider>(context).darkTheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              title: GlobalConfig.appName,
              navigatorKey: navigatorKey,
              debugShowCheckedModeBanner: GlobalConfig.isShowDebugModeBanner,
              theme: isDarkTheme ? dark : light,
              scrollBehavior: const MaterialScrollBehavior().copyWith(
                dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
              ),
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              initialRoute: logged && data != null
                  ? AppRoutes.dashboardScreen
                  : AppRoutes.splashScreen,
              routes: AppRoutes.routes,
              builder: (context, widget) => MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1)),
                child: Material(child: widget),
              ),
            );
          },
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
