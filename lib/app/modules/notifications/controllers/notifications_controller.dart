import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:sharek/core/widgets/snack_bar.dart';

import '../../../data/remote_data_source/notifications_apis.dart';

class NotificationsController extends GetxController {
  Future deleteOneNotifcation(int id) async {
    BotToast.showLoading();
    var res = await NotificationsAPI.deleteOneNoti(id: id);
    if (res?.status == true) {
      showSnackBar(res?.message ?? "");
      BotToast.closeAllLoading();
      Get.forceAppUpdate();
    } else {
      BotToast.closeAllLoading();
      showSnackBar(res?.message ?? "");
    }
  }
}
