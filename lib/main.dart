import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry_logging/sentry_logging.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:round_spot/round_spot.dart' as roundspot;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sharek/app.dart';
import 'package:sharek/firebase_options.dart';

import 'core/global/const.dart';
import 'core/services/shared_prefs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final pref = await SharedPreferences.getInstance();

  globalPrefs = pref;
  Get.put(SharedPrefService(prefs: pref));

//*NOTIFICATIONS:
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings(
    '@mipmap/ic_launcher',
  );
  const IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
    requestSoundPermission: false,
    requestBadgePermission: true,
    requestAlertPermission: true,
  );
  const MacOSInitializationSettings initializationSettingsMacOS =
      MacOSInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: true,
          requestSoundPermission: true);
  const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsMacOS);
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    flutterLocalNotificationsPlugin.show(
        Random().nextInt(12121212122),
        message.notification?.title,
        message.notification?.body,
        const NotificationDetails());
  }

  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://96a341df044045648028d4b5de7a7286@o1189629.ingest.sentry.io/4504901865439232';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.enableAppLifecycleBreadcrumbs = true;
      options.enableAutoPerformanceTracing = true;
      options.enableAutoSessionTracking = true;
      options.enableWatchdogTerminationTracking = true;
      options.enableMemoryPressureBreadcrumbs = true;
      options.enableUserInteractionTracing = true;
      //Logger for Sentry
      options.addIntegration(LoggingIntegration());
      options.tracesSampler = (samplingContext) {
        // return a number between 0 and 1 or null (to fallback to configured value)
        return .5;
      };
    },
    appRunner: () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]).then(
        (value) => runApp(
          ///`ProviderScope` is the widget that holds all our providers
          ///while `roundspot.initialize` is the widget that
          roundspot.initialize(
            child: SentryUserInteractionWidget(child: const MyApp()),

            ///this is round spot configuration for measuring and creating a heat map for User app journey.
            ///To correctly monitor interactions with any scrollable space a `Detector` has to be placed as a direct parent of that widget:
            config: roundspot.Config(
              outputType: roundspot.OutputType.localRender,
              minSessionEventCount: 5,
              uiElementSize: 15,
              //disabledRoutes: ,
              heatMapPixelRatio: 2.0,
              heatMapStyle: roundspot.HeatMapStyle.smooth,
              enabled: true,
            ),
          ),
        ),
      );
    },
  );
}
