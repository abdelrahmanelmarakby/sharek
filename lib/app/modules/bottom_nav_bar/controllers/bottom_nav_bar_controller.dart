import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharek/app/modules/home/views/home_view.dart';

import '../../profile/views/profile_view.dart';

class BottomNavBarController extends GetxController {
  Widget _currentScreen = const HomeView();

  // ignore: non_constant_identifier_names
  get CurrentScreen => _currentScreen;

  int _navIndex = 0;

  set setNavIndex(int value) => _navIndex = value;
  get getNavIndex => _navIndex;
  onSelected(int index) {
    _navIndex = index;
    switch (index) {
      case 0:
        {
          _currentScreen = const HomeView();
          break;
        }
      case 1:
        {
          _currentScreen = const HomeView();
          break;
        }
      case 2:
        {
          _currentScreen = const HomeView();
          break;
        }
      case 3:
        {
          _currentScreen = const HomeView();
          break;
        }
      case 4:
        {
          _currentScreen = const ProfileView();
          break;
        }
    }
    update();
  }
}
