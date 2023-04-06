// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:sharek/core/extensions/export.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../core/constants/theme/colors_manager.dart';
import '../../../../core/constants/theme/font_manager.dart';
import '../../../../core/constants/theme/sizes_manager.dart';
import '../../../../core/global/const.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/network_image.dart';
import '../../../data/models/trip_ads_item_model.dart';
import '../../../data/remote_data_source/trip_ads.dart';
import '../../home/views/home_view.dart';
import '../controllers/travel_partner_controller.dart';
import '../widgets/comment_item.dart';

class TravelPartnerDetailsScreen extends GetView<TravelPartnerController> {
  const TravelPartnerDetailsScreen({
    required this.id,
    Key? key,
  }) : super(key: key);
  final int id;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TravelPartnerController>(
      builder: (controller) {
        return FutureBuilder<TripAdsItemModel?>(
            future: TripPartnerAPI.getTripAdsById(id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final ads = snapshot.data?.data;
                return Scaffold(
                  extendBodyBehindAppBar: true,
                  body: NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        SliverAppBar(
                          floating: false,
                          pinned: true,
                          expandedHeight:
                              MediaQuery.of(context).size.height / 3,
                          leading: GestureDetector(
                            onTap: () => Get.back(),
                            child: Container(
                              height: 40,
                              width: 40,
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.only(right: 6),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                          actions: [
                            GestureDetector(
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.center,
                                child: const Center(
                                  child: Icon(
                                    Iconsax.heart,
                                    size: Sizes.size20,
                                    color: ColorsManager.red,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            GestureDetector(
                              onTap: () {},
                              child: PopupMenuButton(
                                itemBuilder: (BuildContext context) {
                                  return [
                                    PopupMenuItem(
                                        child: Row(
                                      children: [
                                        const Icon(
                                          Icons.share_outlined,
                                          size: 20,
                                        ),
                                        12.widthSizedBox,
                                        const Text("مشاركة الاعلان"),
                                      ],
                                    )),
                                    PopupMenuItem(
                                        child: Row(
                                      children: [
                                        const Icon(
                                          Iconsax.flag,
                                          size: 20,
                                        ),
                                        12.widthSizedBox,
                                        const Text("ابلاغ عن الاعلان"),
                                      ],
                                    ))
                                  ];
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  child: const Center(
                                    child: Icon(
                                      Icons.more_horiz_rounded,
                                      size: Sizes.size20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                          ],
                          flexibleSpace: LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints constraints) {
                              return FlexibleSpaceBar(
                                centerTitle: true,
                                title: const AnimatedOpacity(
                                  duration: Duration(milliseconds: 300),
                                  opacity: 1.0,
                                ),
                                background: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    ListView.separated(
                                      itemCount: ads?.photos?.length ?? 0,
                                      scrollDirection: Axis.horizontal,
                                      physics: const PageScrollPhysics(),
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(width: 10),
                                      itemBuilder: (context, index) {
                                        final image = ads?.photos?[index];
                                        return VisibilityDetector(
                                          key: Key(index.toString()),
                                          onVisibilityChanged: (info) {
                                            controller.changeImageStepper(
                                                index.toDouble());
                                          },
                                          child: AppCachedNetworkImage(
                                            imageUrl: image ?? dummyImage,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      },
                                    ),
                                    ads?.photos?.isNotEmpty ?? false
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DotsIndicator(
                                              dotsCount:
                                                  ads?.photos?.length ?? 0,
                                              position: controller
                                                  .currentImageStepper,
                                              decorator: DotsDecorator(
                                                activeSize: const Size(8, 8),
                                                size: const Size(8, 8),
                                                color: ColorsManager.white
                                                    .withOpacity(
                                                        .4), // Inactive color
                                                activeColor:
                                                    ColorsManager.white,
                                              ),
                                            ),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ];
                    },
                    body: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              ads?.title ?? "",
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeights.semiBold,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                AdRowItem(
                                  icon: Iconsax.clock,
                                  text: ads?.createdAt1 ?? "",
                                ),
                                AdRowItem(
                                  icon: Iconsax.location,
                                  text: ads?.startingPlace ?? "",
                                ),
                                AdRowItem(
                                  icon: Iconsax.location_tick,
                                  text: ads?.endingPlace ?? "",
                                ),
                              ],
                            ),
                            const SizedBox(height: 13),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AdRowItem(
                                  icon: Iconsax.user,
                                  text: ads?.userName ?? "",
                                ),
                                AdRowItem(
                                  icon: Iconsax.car,
                                  text: ads?.carType ?? "راكب",
                                ),
                                AdRowItem(
                                  icon: Iconsax.calendar,
                                  text: ads?.date ?? "",
                                )
                              ],
                            ),
                            const SizedBox(height: 16),
                            Divider(
                              color: Colors.grey.withOpacity(.2),
                            ),
                            const SizedBox(height: 16),
                            const AppText(
                              "التفاصيل",
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeights.semiBold,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const Expanded(
                                  child: AppText(
                                    "هل يقبل طرود:",
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Expanded(
                                  child: AppText(
                                    ads?.withPackages == true ? "نعم" : "لا",
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Expanded(
                                  child: AppText(
                                    "سعر الرحلة:",
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Expanded(
                                  child: AppText(
                                    "${ads?.price.toString()} ريال",
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Expanded(
                                  child: AppText(
                                    "عدد الركاب:",
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Expanded(
                                  child: AppText(
                                    "${ads?.numberPassengers.toString()} ركاب",
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Expanded(
                                  child: AppText(
                                    "تاريخ الرحلة:",
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Expanded(
                                  child: AppText(
                                    ads?.date ?? "",
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Expanded(
                                  child: AppText(
                                    "وقت الرحلة:",
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Expanded(
                                  child: AppText(
                                    ads?.time ?? "",
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Divider(
                              color: Colors.grey.withOpacity(.2),
                            ),
                            const SizedBox(height: 16),
                            const AppText(
                              "طرق التواصل",
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeights.semiBold,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  flex: 35,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: ColorsManager.primary,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Iconsax.call,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 10),
                                        AppText(
                                          "إتصال",
                                          fontSize: 14,
                                          fontWeight: FontWeights.regular,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  flex: 35,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: ColorsManager.white,
                                      border: Border.all(
                                        color: ColorsManager.primary,
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 11),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Iconsax.sms,
                                          color: ColorsManager.primary,
                                        ),
                                        SizedBox(width: 10),
                                        AppText(
                                          "مراسلة",
                                          fontSize: 14,
                                          color: ColorsManager.primary,
                                          fontWeight: FontWeights.regular,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Spacer(flex: 15),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Divider(
                              color: Colors.grey.withOpacity(.2),
                            ),
                            const SizedBox(height: 16),
                            const AppText(
                              "التعليقات",
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeights.semiBold,
                            ),
                            const SizedBox(height: 8),
                            CustomTextField(
                              name: "",
                              hint: "أكتب تعليقك هنا",
                              borderRadius: 8,
                              controller: controller.createCommentCtr,
                              onChange: controller.onChangedComment,
                              isResendSuffixIcon: true,
                              type: TextInputType.text,
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  onTap: () {
                                    controller.isText
                                        ? controller.createComment(
                                            comment: controller
                                                .createCommentCtr.text,
                                            id: ads?.advertisementId ?? 0,
                                          )
                                        : null;
                                  },
                                  child: SvgPicture.asset(
                                    "assets/images/send.svg",
                                    color: !controller.isText
                                        ? Colors.grey.withOpacity(.4)
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: ads?.comments?.length ?? 0,
                              itemBuilder: (context, index) {
                                Comments? comment = ads?.comments?[index];
                                return CommentItemWidget(
                                  comment: comment?.comment ?? "",
                                  createdAt: comment?.createdAt ?? "",
                                  image: comment?.avatar ?? dummyImage,
                                  username: comment?.userName ?? "",
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: AppText(
                    "لا يوجد بيانات",
                    color: Colors.black,
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation(ColorsManager.primary),
                  ),
                );
              }
            });
      },
    );
  }
}
