// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:sharek/app/data/models/ads_model.dart';
import 'package:sharek/app/data/models/home_model.dart';
import 'package:sharek/app/modules/home/views/home_view.dart';
import 'package:sharek/core/constants/theme/colors_manager.dart';
import 'package:sharek/core/constants/theme/font_manager.dart';
import 'package:sharek/core/constants/theme/sizes_manager.dart';
import 'package:sharek/core/constants/theme/styles_manager.dart';
import 'package:sharek/core/extensions/num.dart';
import 'package:sharek/core/extensions/widget.dart';
import 'package:sharek/core/widgets/custom_text_field.dart';

import '../controllers/business_partner_controller.dart';
import 'business_partner_details_screen.dart';
import 'bussiness_partner_filter_screen.dart';

class BusinessPartnerView extends GetView<BusinessPartnerController> {
  const BusinessPartnerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('شريك أعمال'),
        centerTitle: true,
      ),
      body: FutureBuilder<AdsModel?>(
        future: controller.getBusinessAds,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final AdsModel? model = snapshot.data;
            return SingleChildScrollView(
                child: Column(
              children: [
                CustomTextField(
                  name: "BusinessSearch",
                  hint: "ابحث هنا",
                  prefixIcon: const Icon(Iconsax.search_normal),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      Get.to(() => const BussinessPartnerFilterScreen());
                    },
                    child: const Icon(
                      Iconsax.filter,
                    ),
                  ),
                ),
                Sizes.size12.h(context).heightSizedBox,
                const FiltersList(),
                Sizes.size20.h(context).heightSizedBox,
                SizedBox(
                  width: context.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "الاعلانات الجديدة",
                        style: StylesManager.bold(fontSize: FontSize.xlarge),
                      ),
                    ],
                  ),
                ),
                Sizes.size8.h(context).heightSizedBox,
                Column(
                  children: List.generate(model!.data?.length ?? 0, (index) {
                    final Ad? ad = model.data?[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(
                          () => BusinessPartnerDetailsScreen(
                            ad: ad,
                          ),
                        );
                      },
                      child: AdCard(
                        ad: NewAdvertisements(
                          title: ad?.title,
                          photos: ad?.photos,
                          advertisementId: ad?.advertisementId,
                          createdAt1: ad?.createdAt1,
                          createdAt2: ad?.createdAt2,
                          location: ad?.location,
                          neighborhood: ad?.neighborhood,
                          userName: ad?.userName,
                        ),
                      ),
                    );
                  }),
                )
              ],
            )).horizontalScreenPadding;
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation(ColorsManager.primary),
              ),
            );
          }
        },
      ),
    );
  }
}

class FiltersList extends StatelessWidget {
  const FiltersList({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Wrap(
        alignment: WrapAlignment.start,
        runSpacing: 8,
        spacing: 8,
        children: [
          "بحث عن شريك",
          "إعلانات البائعين",
          "محاماة",
          "فرنشايز",
          " خدمات اخرى",
        ]
            .asMap()
            .entries
            .map(
              (e) => GestureDetector(
                child: AppFilterChip(
                  title: e.value,
                  selected: e.key == 0 ? true : false,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class AppFilterChip extends StatelessWidget {
  const AppFilterChip({
    super.key,
    required this.title,
    this.selected = false,
    this.onSelected,
  });
  final String title;

  final bool selected;

  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      selectedColor: ColorsManager.primary,
      showCheckmark: false,
      selected: selected,
      side: const BorderSide(width: 1, color: Color(0xffE4E4E6)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          8,
        ),
      ),
      backgroundColor: const Color(0xffF7F7F7),
      padding: EdgeInsets.symmetric(
          vertical: 12.w(context), horizontal: 16.w(context)),
      label: Text(
        title,
        style: StylesManager.regular(
          color: selected ? Colors.white : Colors.black,
          fontSize: FontSize.medium,
        ),
      ),
      onSelected: (bool selected) {
        onSelected != null ? onSelected!(selected) : null;
      },
    );
  }
}
