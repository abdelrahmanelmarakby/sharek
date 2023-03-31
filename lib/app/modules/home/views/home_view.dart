import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sharek/app/data/models/home_model.dart';
import 'package:sharek/app/routes/app_pages.dart';
import 'package:sharek/core/constants/theme/colors_manager.dart';
import 'package:sharek/core/constants/theme/font_manager.dart';
import 'package:sharek/core/constants/theme/sizes_manager.dart';
import 'package:sharek/core/constants/theme/styles_manager.dart';
import 'package:sharek/core/extensions/num.dart';
import 'package:sharek/core/extensions/widget.dart';
import 'package:sharek/core/language/local_keys.dart';
import 'package:sharek/core/widgets/custom_text_field.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'شريك',
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<HomeModel?>(
        future: controller.getHomeData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final HomeModel? homeData = snapshot.data;
            print(homeData.toString());
            return SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    CustomTextField(
                      name: LocalKeys.search,
                      hint: LocalKeys.search.tr,
                      prefixIcon: const Icon(Iconsax.search_normal),
                    ),
                    Sizes.size16.h(context).heightSizedBox,
                    const ServicesList(),
                    Sizes.size16.h(context).heightSizedBox,
                    SizedBox(
                      width: context.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "الاعلانات الجديدة",
                            style:
                                StylesManager.bold(fontSize: FontSize.xlarge),
                          ),
                          Sizes.size10.heightSizedBox,
                          ...List.generate(20, (index) {
                            NewAdvertisements? ad =
                                homeData?.data?.newAdvertisements?[index];
                            return AdCard(ad: ad);
                          })
                        ],
                      ),
                    )
                  ],
                ).horizontalScreenPadding,
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      ),
    );
  }
}

class AdCard extends StatelessWidget {
  const AdCard({
    super.key,
    required this.ad,
  });

  final NewAdvertisements? ad;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
            height: context.height / 7,
            width: context.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border:
                    Border.all(width: .5, color: ColorsManager.veryLightGrey),
                color: const Color(
                  0xffF7F7F9,
                )),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            (ad?.title) ?? "",
                            overflow: TextOverflow.clip,
                            style: StylesManager.bold(fontSize: FontSize.large),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              AdRowItem(
                                  icon: Iconsax.clock,
                                  text: ad?.createdAt1 ?? ""),
                              AdRowItem(
                                  icon: Iconsax.location,
                                  text: ad?.location ?? "")
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AdRowItem(
                                  icon: Iconsax.user, text: ad?.userName ?? ""),
                              AdRowItem(
                                  icon: Iconsax.routing,
                                  text: ad?.neighborhood ?? "")
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Flexible(
                      fit: FlexFit.loose,
                      flex: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          ad?.photos?[0] ?? "",
                          height: context.width / 4,
                          width: context.width / 4,
                          fit: BoxFit.cover,
                        ),
                      )),
                ],
              ),
            )));
  }
}

class AdRowItem extends StatelessWidget {
  const AdRowItem({
    super.key,
    required this.icon,
    required this.text,
  });
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Icon(
            icon,
            color: ColorsManager.grey,
            size: Sizes.size18,
          ),
          Sizes.size4.widthSizedBox,
          Expanded(
            child: Text(
              text,
              style: StylesManager.regular(fontSize: FontSize.small),
            ),
          ),
        ],
      ),
    );
  }
}

class ServicesList extends StatelessWidget {
  const ServicesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * .2,
      width: context.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "الخدمات",
            style: StylesManager.bold(fontSize: FontSize.xlarge),
          ),
          Sizes.size10.heightSizedBox,
          Expanded(
              child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              PartnerCard(
                  serviceId: 1,
                  name: "شريك اعمال",
                  imagePath: "assets/images/business_partner.svg"),
              PartnerCard(
                  serviceId: 2,
                  name: "شريك رحلتي",
                  imagePath: "assets/images/travel_partner.svg"),
              PartnerCard(
                  serviceId: 3,
                  name: "شريك ذبيحتي",
                  imagePath: "assets/images/sake_partner.svg"),
              PartnerCard(
                  serviceId: 4,
                  name: "شريك سكني",
                  imagePath: "assets/images/housing_partner.svg"),
              PartnerCard(
                  serviceId: 5,
                  name: "اخري",
                  imagePath: "assets/images/business_partner.svg"),
            ],
          )),
        ],
      ),
    );
  }
}

class PartnerCard extends StatelessWidget {
  const PartnerCard(
      {super.key,
      required this.name,
      required this.imagePath,
      required this.serviceId});
  final String name;
  final String imagePath;
  final int serviceId;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.size8),
      child: GestureDetector(
        onTap: () {
          print(serviceId);
          switch (serviceId) {
            case 1:
              Get.toNamed(Routes.BUSINESS_PARTNER);
              break;
            case 2:
              Get.toNamed(Routes.TRAVEL_PARTNER);
              break;
            case 3:
              Get.toNamed(Routes.SAKE_PARTNER);
              break;
            case 4:
              Get.toNamed(Routes.HOUSE_PARTNER);
              break;

            default:
              Get.toNamed(Routes.OTHER_SERVICE_PARTNER);
          }
        },
        child: Column(
          children: [
            Container(
              height: 80.h(context),
              width: 80.h(context),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(width: .5, color: ColorsManager.veryLightGrey),
                  color: const Color(
                    0xffF7F7F9,
                  )),
              child: Center(
                child: SvgPicture.asset(
                  imagePath,
                  height: 35,
                  width: 35,
                ),
              ),
            ),
            Sizes.size8.heightSizedBox,
            Text(
              name,
              style: StylesManager.semiBold(fontSize: FontSize.medium),
            )
          ],
        ),
      ),
    );
  }
}
