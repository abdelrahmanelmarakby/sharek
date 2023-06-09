import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AnotherUserProfileController extends GetxController {
  void makePhoneCall(String phone) async {
    var url = 'tel:$phone';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
