import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sharek/core/services/firebase_messaging_helper.dart';

import 'app/modules/others/error_screen.dart';
import 'app/modules/others/no_internet_dialog.dart';
import 'app/routes/app_pages.dart';
import 'core/language/local_keys.dart';
import 'core/language/translations_service.dart';
import 'core/services/bindings.dart';
import 'core/services/get_storage_helper.dart';
import 'core/services/theme.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  bool _backViewOn = true;
  final botToastBuilder = BotToastInit();

  @override
  void initState() {
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (!await InternetConnectionChecker().hasConnection) {
        if (!_backViewOn) {
          setState(() {
            _backViewOn = true;
          });
          Get.dialog(const NoInternetDialog(canDismiss: false));
        }
      } else {
        if (_backViewOn) {
          Get.back();
          setState(() {
            _backViewOn = false;
          });
        }
      }
    });
    super.initState();
    NotificationService notificationService = NotificationService();

    notificationService.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorObservers: [BotToastNavigatorObserver()],
      title: LocalKeys.appName.tr,
      initialRoute: AppPages.INITIAL,
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBindings(),
      getPages: AppPages.routes,
      darkTheme: Themes.dark,
      // <-- dark theme
      theme: Themes.light,
      // <-- light theme
      themeMode: ThemeService().theme,

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale(CacheHelper.getLocale),
      fallbackLocale: TranslationsService.fallbackLocale,
      supportedLocales: TranslationsService.supportedLocales,

      translations: TranslationsService(),
      defaultTransition: Transition.fadeIn,
      builder: (context, child) {
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return CustomError(errorDetails: errorDetails);
        };
        child = botToastBuilder(context, child!);
        return ResponsiveWrapper.builder(
          ClampingScrollWrapper.builder(context, child),
          maxWidth: 1200,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(350, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(600, name: TABLET),
            const ResponsiveBreakpoint.resize(800, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
          ],
          background: Container(
            color: const Color(0xFFF5F5F5),
          ),
        );
      },
    );
  }
}
