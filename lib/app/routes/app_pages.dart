import 'package:get/get.dart';

import '../../core/global/const.dart';
import '../../core/services/get_storage_helper.dart';
import '../../core/services/shared_prefs.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/bottom_nav_bar/bindings/bottom_nav_bar_binding.dart';
import '../modules/bottom_nav_bar/views/bottom_nav_bar_view.dart';
import '../modules/business_partner/bindings/business_partner_binding.dart';
import '../modules/business_partner/views/business_partner_view.dart';
import '../modules/chats/chat_history.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/house_partner/bindings/house_partner_binding.dart';
import '../modules/house_partner/views/house_partner_view.dart';
import '../modules/location_getter_widgets/bindings/location_getter_widgets_binding.dart';
import '../modules/location_getter_widgets/views/location_getter_widgets_view.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';
import '../modules/other_service_partner/bindings/other_service_partner_binding.dart';
import '../modules/other_service_partner/views/other_service_partner_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/sake_partner/bindings/sake_partner_binding.dart';
import '../modules/sake_partner/views/sake_partner_view.dart';
import '../modules/travel_partner/bindings/travel_partner_binding.dart';
import '../modules/travel_partner/views/travel_partner_view.dart';
import '../modules/video_chat/bindings/video_chat_binding.dart';
import '../modules/video_chat/views/video_chat_view.dart';

// ignore_for_file: non_constant_identifier_names

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.BOTTOM_NAV_BAR;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOM_NAV_BAR,
      page: () => const BottomNavBarView(),
      binding: BottomNavBarBinding(),
    ),
    GetPage(
      name: _Paths.BUSINESS_PARTNER,
      page: () => const BusinessPartnerView(),
      binding: BusinessPartnerBinding(),
    ),
    GetPage(
      name: _Paths.TRAVEL_PARTNER,
      page: () => const TravelPartnerView(),
      binding: TravelPartnerBinding(),
    ),
    GetPage(
      name: _Paths.SAKE_PARTNER,
      page: () => const SakePartnerView(),
      binding: SakePartnerBinding(),
    ),
    GetPage(
      name: _Paths.HOUSE_PARTNER,
      page: () => const HousePartnerView(),
      binding: HousePartnerBinding(),
    ),
    GetPage(
      name: _Paths.OTHER_SERVICE_PARTNER,
      page: () => const OtherServicePartnerView(),
      binding: OtherServicePartnerBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: _Paths.CHATS,
      page: () => ChatHistory(
        myId: CacheHelper.getUserId ?? "",
      ),
    ),
    GetPage(
      name: _Paths.VIDEO_CHAT,
      page: () => const VideoChatView(),
      binding: VideoChatBinding(),
    ),
    GetPage(
      name: _Paths.LOCATION_GETTER_WIDGETS,
      page: () => const LocationGetterWidgetsView(),
      binding: LocationGetterWidgetsBinding(),
    ),
  ];
}
