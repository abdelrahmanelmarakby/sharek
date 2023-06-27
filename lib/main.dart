// ignore_for_file: non_constant_identifier_names
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry_logging/sentry_logging.dart';
import 'package:round_spot/round_spot.dart' as roundspot;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharek/app.dart';
import 'package:sharek/firebase_options.dart';
// import 'package:workmanager/workmanager.dart';
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
  // Workmanager().initialize(
  //   callbackDispatcher,
  //   isInDebugMode: true,
  // );
  // Workmanager().registerPeriodicTask(
  //   "2",
  //   "simplePeriodicTask",
  //   frequency: const Duration(minutes: 60),
  // );
  globalPrefs = pref;
  Get.put(SharedPrefService(prefs: pref));
  // final messaging = FirebaseMessaging.instance;
  // final settings = await messaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );
  // timeago.setLocaleMessages("ar", MyCustomMessages());
  // if (kDebugMode) {
  //   print('Permission granted: ${settings.authorizationStatus}');
  // }
  await SentryFlutter.init(
    (options) {
      options.dsn = APIKeys.sentryKey;
      options.enableAppLifecycleBreadcrumbs = true;
      options.enableAutoPerformanceTracing = true;
      options.enableAutoSessionTracking = true;
      options.enableWatchdogTerminationTracking = true;
      options.enableMemoryPressureBreadcrumbs = true;
      options.enableUserInteractionTracing = true;
      options.addIntegration(LoggingIntegration());
      options.tracesSampler = (samplingContext) {
        return .5;
      };
    },
    appRunner: () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]).then(
        (value) => runApp(
          roundspot.initialize(
            child: SentryUserInteractionWidget(child: const MyApp()),
            config: roundspot.Config(
              outputType: roundspot.OutputType.localRender,
              minSessionEventCount: 5,
              uiElementSize: 15,
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

// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) {
//     FlutterLocalNotificationsPlugin flip = FlutterLocalNotificationsPlugin();
//     var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
//     var IOS = const IOSInitializationSettings();
//     var settings = InitializationSettings(android: android, iOS: IOS);
//     flip.initialize(settings);
//     _showNotificationWithDefaultSound(flip);
//     return Future.value(true);
//   });
// }

// Future _showNotificationWithDefaultSound(flip) async {
//   var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
//     'your channel id',
//     'your channel name',
//     'your channel description',
//     importance: Importance.max,
//     priority: Priority.high,
//   );
//   var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
//   var platformChannelSpecifics = NotificationDetails(
//     android: androidPlatformChannelSpecifics,
//     iOS: iOSPlatformChannelSpecifics,
//   );
//   await flip.show(
//     0,
//     'شريك',
//     'ابحث الان علي شريك لمشروعك او للسكن',
//     platformChannelSpecifics,
//     payload: 'Default_Sound',
//   );
// }
