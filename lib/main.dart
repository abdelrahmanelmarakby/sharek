// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry_logging/sentry_logging.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:round_spot/round_spot.dart' as roundspot;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sharek/app.dart';
import 'package:sharek/firebase_options.dart';
import 'package:workmanager/workmanager.dart';

import 'core/global/const.dart';
import 'core/services/get_storage_helper.dart';
import 'core/services/shared_prefs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final pref = await SharedPreferences.getInstance();
  GetStorage.init();
  log(CacheHelper.getUserToken.toString());
  log(CacheHelper.getUserId.toString());

  Workmanager().initialize(

      // The top level function, aka callbackDispatcher
      callbackDispatcher,

      // If enabled it will post a notification whenever
      // the task is running. Handy for debugging tasks
      isInDebugMode: true);
  // Periodic task registration
  Workmanager().registerPeriodicTask(
    "2",

    //This is the value that will be
    // returned in the callbackDispatcher
    "simplePeriodicTask",

    // When no frequency is provided
    // the default 15 minutes is set.
    // Minimum frequency is 15 min.
    // Android will automatically change
    // your frequency to 15 min
    // if you have configured a lower frequency.
    frequency: const Duration(minutes: 60),
  );
  globalPrefs = pref;
  Get.put(SharedPrefService(prefs: pref));
  final messaging = FirebaseMessaging.instance;

  final settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (kDebugMode) {
    print('Permission granted: ${settings.authorizationStatus}');
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

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    // initialise the plugin of flutterlocalnotifications.
    FlutterLocalNotificationsPlugin flip = FlutterLocalNotificationsPlugin();

    // app_icon needs to be a added as a drawable
    // resource to the Android head project.
    var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var IOS = const IOSInitializationSettings();

    // initialise settings for both Android and iOS device.
    var settings = InitializationSettings(android: android, iOS: IOS);
    flip.initialize(settings);
    _showNotificationWithDefaultSound(flip);
    return Future.value(true);
  });
}

Future _showNotificationWithDefaultSound(flip) async {
  // Show a notification after every 15 minute with the first
  // appearance happening a minute after invoking the method
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      importance: Importance.max, priority: Priority.high);
  var iOSPlatformChannelSpecifics = const IOSNotificationDetails();

  // initialise channel platform for both Android and iOS device.
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);
  await flip.show(0, 'شريك', 'ابحث الان علي شريك لمشروعك او للسكن',
      platformChannelSpecifics,
      payload: 'Default_Sound');
}
