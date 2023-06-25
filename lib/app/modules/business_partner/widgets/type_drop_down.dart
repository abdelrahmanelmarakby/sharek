import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sharek/core/extensions/num.dart';

import '../../../../core/constants/theme/colors_manager.dart';
import '../../../../core/constants/theme/font_manager.dart';
import '../../../../core/constants/theme/sizes_manager.dart';
import '../../../../core/constants/theme/styles_manager.dart';
import '../../../../core/widgets/custom_dropdown.dart';
import '../../../data/models/bussiness_type_model.dart';
import '../controllers/business_partner_controller.dart';

class TypeDropDown extends GetView<BusinessPartnerController> {
  const TypeDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BusinessPartnerController>(
      builder: (controller) {
        return AppDropDown(
          title: controller.bussinessTypeModel != null
              ? (controller.bussinessTypeModel?.title ?? "")
              : "النوع",
          bottomSheet: SizedBox(
            height: context.height * .4,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(child: Sizes.size8.h(context).heightSizedBox),
                      IconButton(
                        onPressed: () {
                          Get.close(1);
                        },
                        icon: const Icon(
                          Icons.cancel,
                          color: ColorsManager.primary,
                          size: Sizes.size38,
                        ),
                      ),
                    ],
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: bussinessTypeList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => const Divider(
                      color: ColorsManager.veryLightGrey,
                    ),
                    itemBuilder: (context, index) {
                      BussinessTypeModel item = bussinessTypeList[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            controller.pickTypeId(item);
                          },
                          child: Text(
                            item.title,
                            textAlign: TextAlign.center,
                            style: StylesManager.bold(fontSize: FontSize.large),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          icon: const RotatedBox(
            quarterTurns: 2,
            child: Icon(Iconsax.category),
          ),
        );
      },
    );
  }
}
