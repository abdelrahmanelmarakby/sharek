import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // late final Future<HomeModel?> getHomeData;
  @override
  void onInit() {
    // getHomeData = HomeAPI.getHome();
    super.onInit();
  }

  refreshHomeScreen() {
    // getHomeData = HomeAPI.getHome();
    update();
  }

  String? homeSearch;
  TextEditingController searchController = TextEditingController();
  onChangedSearch(String value) {
    if (value.trim().isNotEmpty) {
      searchController.text = value;
      homeSearch = value;
    } else {
      homeSearch = value;
    }
    searchController.value = searchController.value.copyWith(
      text: value,
      selection: TextSelection.fromPosition(
        TextPosition(offset: value.length),
      ),
    );
    update();
  }
}
