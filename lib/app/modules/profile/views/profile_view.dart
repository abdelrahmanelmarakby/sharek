// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sharek/app/data/remote_data_source/profile_apis.dart';
import 'package:sharek/app/modules/profile/bindings/profile_binding.dart';
import 'package:sharek/core/constants/theme/colors_manager.dart';
import 'package:sharek/core/constants/theme/font_manager.dart';
import 'package:sharek/core/constants/theme/styles_manager.dart';
import 'package:sharek/core/extensions/export.dart';
import 'package:sharek/core/global/const.dart';
import 'package:sharek/core/widgets/app_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/theme/sizes_manager.dart';
import '../../../data/models/profile_model.dart';
import '../controllers/profile_controller.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_list_tile.dart';
import 'account_erification_request_screen.dart';
import 'edit_user_info_screen.dart';
import 'favorites_screen.dart';
import 'my_ads_screen.dart';
import 'notification_settings_screen.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حسابي'),
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Get.forceAppUpdate();
        },
        child: FutureBuilder<UserInfoModel?>(
          future: ProfileApis.getUserProfile(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserInfoModel? userData = snapshot.data!;
              Get.log(userData.toString());
              return SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Sizes.size20.h(context).heightSizedBox,
                      ProfileHeader(
                        name: userData.data?.name ?? "",
                        userImage: userData.data?.avatar ?? dummyImage,
                      ),
                      Sizes.size8.h(context).heightSizedBox,
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              "إعدادت الحساب",
                              fontSize: Sizes.size16.h(context),
                              fontWeight: FontWeights.semiBold,
                              color: ColorsManager.primary,
                            ),
                            Sizes.size8.h(context).heightSizedBox,
                            ProfileListTile(
                              title: "المعلومات شخصية",
                              onTap: () {
                                Get.to(
                                  () => const EditUserInfoScreen(),
                                  binding: ProfileBinding(),
                                );
                              },
                            ),
                            Sizes.size4.h(context).heightSizedBox,
                            ProfileListTile(
                              title: "إعلاناتي",
                              onTap: () {
                                Get.to(
                                  () => const MyAdsScreen(),
                                  binding: ProfileBinding(),
                                );
                              },
                            ),
                            Sizes.size4.h(context).heightSizedBox,
                            ProfileListTile(
                              title: "المفضلة",
                              onTap: () {
                                Get.to(
                                  () => const FavoritesScreen(),
                                  binding: ProfileBinding(),
                                );
                              },
                            ),
                            Sizes.size4.h(context).heightSizedBox,
                            ProfileListTile(
                              title: 'إعدادت التطبيق',
                              onTap: () {
                                Get.to(
                                  () => NotificationSettingsScreen(
                                    phone:
                                        userData.data?.phone.toString() ?? "",
                                  ),
                                  binding: ProfileBinding(),
                                );
                              },
                            ),
                            Sizes.size4.h(context).heightSizedBox,
                            ProfileListTile(
                              title: "طلب توثيق الحساب",
                              isLast: true,
                              onTap: () {
                                Get.to(
                                  () =>
                                      const AccountVerificationRequestScreen(),
                                  binding: ProfileBinding(),
                                );
                              },
                            ),
                            Sizes.size24.h(context).heightSizedBox,
                            AppText(
                              "الدعم",
                              fontSize: Sizes.size14.h(context),
                              fontWeight: FontWeights.medium,
                              color: ColorsManager.primary,
                            ),
                            ProfileListTile(
                              title: "تواصل معنا",
                              onTap: () {
                                launchUrl(
                                  Uri.parse(
                                      "https://api.whatsapp.com/send?phone=966537420496"),
                                  mode: LaunchMode.externalApplication,
                                );
                              },
                            ),
                            Sizes.size4.h(context).heightSizedBox,
                            ProfileListTile(
                              title: "معلومات عنا",
                              onTap: () {
                                Get.to(() => Scaffold(
                                      appBar: AppBar(
                                        title: const Text("معلومات عنا"),
                                      ),
                                      body: const Column(
                                        children: [
                                          Text("""
""")
                                        ],
                                      ),
                                    ));
                              },
                            ),
                            Sizes.size4.h(context).heightSizedBox,
                            ProfileListTile(
                              title: "الشروط و سياسة الخصوصية",
                              onTap: () {
                                Get.to(() => Scaffold(
                                      appBar: AppBar(
                                        title: const Text(
                                            "الشروط و سياسة الخصوصية"),
                                      ),
                                      body: const SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("""الأحكام  والشروط  : 
                                      - تعريف بالتطبيق  : 
                                      1 - الطرف الأول تطبيق شريك : شريك هو تطبيق إعلاني سعودي جديد بخدمات جديدة ومتميزة، مختص في جمع الشركاء في عدة مجالات مختلفة مع الأشخاص الأنسب لموقعك واهتمامك. 
                                      ابرز خدمات المنصة :  
                                        •	شريك أعمال : وهو الشراكة والبيع في جميع انواع الأراضي والعقارات والمشاريع التجارية والتقنية.  
                                        •	شريك ذبيحتي  : وهو الشراكة والبيع في جميع أنواع الذبائح والمواشي.  
                                        •	شريك رحلتي  : وهو الشراكة في الرحلات الداخلي ة للتنقل ونقل الطرود عبر المناطق والمدن السعودية.  
                                        •	شريك سكني : وهو تأجير الشقق والشراكة في السكن التشاركي مع الأشخاص من هم من نفس الجنس.  
                                       
                                      2 - الطرف الثاني المستخدم  : هو منشئ الحساب على تطبيق شريك لغرض البحث عن الشراكة ا و التواصل أو التصفح أو نشر وبيع منتجاته أو خدماته عبر التطبيق.  
                                       
                                      - اتفاقية الاستخدام والإعلان  : 
                                       على مستفيد ومستخدم تطبيق شريك وهو)  الطرف الثاني(  الالتزام بالشروط الاتية:   
                                        •	عدم الإعلان أو تحميل محتوى أو عناصر غير ملائمة.  
                                        •	عدم التلاعب بأسعار السلع سواء في البيع او الشراء وإلحاق الضرر بالآخرين.  
                                        •	عدم تقديم بلاغاً كيدياُ على أي مستخدم او تقوم بتقييم غير منصف لأي مستخدم.  
                                        •	عدم تقديم معلومات غير صحيحة اثناء رفع طلب إعلاني على التطبيق.  
                                        •	عدم الاختراق أو التحايل على قوانين وسياسة وأنظمة التطبيق أو أي حقوق تتعلق بطرف ثالث.  
                                        •	عدم استخدام أي وسيلة غير شرعية للوصول للإعلانات أو لبيانات المستخدمين الآخرين أو انتهاك لسياسة وحقوق تطبيق شريك ، أو الوصول لمحتوى الموقع أو تجميع وتحصيل معلومات وبيانات تخص تطبيق شريك أو عملاء الموقع والاستفادة منها بأي شكل من الأشكال أو إعادة نشرها.  
                                      7-عدم التلاعب أو الاحتيال في البيع أو الشراء أو الاستثمار أو الشراكة بالمستخدمين الآخرين أو الأطراف الأخرى وإلحاق الضرر بهم.  
                                        •	عدم انتهاك حقوق الآخرين الملكية أو الفكرية أو براءة الاختراع.  
                                        •	عدم جمع معلومات عن مستخدمي الموقع الآخرين لأغراض تجارية أو شخصية أو غيرها.  
                                        •	يحق تطبيق شريك حذف وإلغاء حسابك في حال وجود أي تجاوز.  
                                        •	يلزم المستخدم المسجل في شريك أنه الوحيد الذي يستخدم الحساب ويكون مسؤولا عن كل ما يتم عبر حسابه، ولا يسمح استخدام اكثر من حساب لغرض التحايل او إخفاء الهوية.  
                                        •	يجب أن يكون اسم المستخدم اسم له معنى وليس مجرد رموز أو أرقام ويمنع استخدام أي أسماء تحرض على الكراهية والعنف أو استخدام أي من العلامات التجارية او أسماء لأشخاص اخرين كاسم للمستخدم.  
                                        •	عدم استخدام خدماتنا إذا كنت غير مؤهل قانونيا لإتمام هذه الاتفاقية. على سبيل المثال أنك أقل من 18 سنة أو أنك محجوب بشكل مؤقت أو دائم من استخدام الموقع.  
                                        •	عدم الإعلان عن كل ما يعرضك للحصول على مخالفة من قبل الجهات المختصة.  
                                       
                                        •	عدم انتهاك أنظمة حقوق الإنسان أو أنظمة حماية الحياة الفطرية.  
                                        •	لا يعتبر الطرف الأول )تطبيق شريك (  طرفاً في أي علاقة تعاقدية بين الشركاء وتعتبر صفحة إعلانية مستقلة . 
                                       
                                      سياسة الخصوصية:   
                                        •	إن بيانات التسجيل والمعلومات الأخرى التي تتعلق بك تندرج تحت هام وسري للغاية، كما انها تندرج تحت سياسة الخصوصية التي يتبعها تطبيق شريك. ولن تستخدم تلك البيانات او المعلومات إلا بالطريقة الملائمة،  ولن يتم نشرها او مشاركتها مع أي طرف اخر.  
                                        •	يقدم تطبيق شريك خدمة تمكين المستخدم من عرض إعلانه وفق سياسة الاستخدام المتفق عليها ولا نقدم أي ضمانات ولا نتحمل أي مسؤولية في حالة عدم التزام المستخدم بسياسة استخدام الموقع ولا نتحمل المسؤولية عن أي مخاطرة أو أضرار أو تبعات أو خسائر تقع على البائع أو المشتري أو المستثمر أو الشريك أو المستخدم أو أي طرف آخر وعلى من لحق به الضر التوجه للجهات الأمنية.  
                                        •	هذه السياسة محل تغيير دائم وتطوير، مع إشعار المستخدمين بذلك، وعلى المستخدمين مراجعة هذه السياسات بشكل دور ي وفوري.  
                                      
                                      """)
                                          ],
                                        ),
                                      ),
                                    ));
                              },
                            ),
                            Sizes.size12.h(context).heightSizedBox,
                            GestureDetector(
                              onTap: () {
                                controller.logOut();
                              },
                              child: Text(
                                "تسجيل الخروج",
                                style: StylesManager.medium(
                                    fontSize: Sizes.size14.h(context),
                                    color: ColorsManager.red),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation(ColorsManager.primary),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
