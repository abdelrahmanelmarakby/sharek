import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sharek/core/extensions/num.dart';

import '../../../../core/constants/theme/colors_manager.dart';
import '../../../../core/constants/theme/font_manager.dart';
import '../../../../core/constants/theme/sizes_manager.dart';
import '../../../../core/constants/theme/styles_manager.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../data/remote_data_source/location_apis.dart';
import '../models/cities_model.dart';

class AllCitiesWidget extends StatefulWidget {
  const AllCitiesWidget({super.key});

  @override
  State<AllCitiesWidget> createState() => _AllCitiesWidgetState();
}

class _AllCitiesWidgetState extends State<AllCitiesWidget> {
  int? cityId;
  CitiesModel? cities;
  String? cityName;
  List<CityModel> searchCities = [];

  selectCityId({required int id, required String name}) async {
    setState(() {
      cityId = id;
      cityName = name;
    });
    Get.back(result: name);
  }

  List<CityModel> searchCity(List<CityModel> model, String text) {
    List<CityModel> matchedList = [];
    if (text == "") {
      setState(() {});
      return model;
    }

    for (CityModel? element in model) {
      if ((element?.name?.toLowerCase() ?? "").contains(text)) {
        matchedList.add(element!);
      }
    }
    setState(() {});
    return matchedList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CitiesModel?>(
      future: LocationApis.getCitiesById(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<CityModel> cities = snapshot.data?.data ?? [];
          if (searchCities.isEmpty) {
            searchCities = cities;
          }
          return Container(
            height: context.height * .5,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 25,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTextField(
                    hint: "ابحث هنا ",
                    height: 40.h(context),
                    onChange: (value) {
                      searchCities = searchCity(cities, value);
                    },
                    suffixIcon: const Icon(Iconsax.search_normal),
                  ),
                  Sizes.size18.h(context).heightSizedBox,
                  const Divider(
                    color: ColorsManager.veryLightGrey,
                  ),
                  ...List.generate(
                    searchCities.length,
                    (index) => Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () => selectCityId(
                              id: searchCities[index].id ?? 0,
                              name: searchCities[index].name ?? "",
                            ),
                            child: Text(
                              searchCities[index].name ?? "",
                              style: StylesManager.bold(
                                fontSize: FontSize.large,
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          color: ColorsManager.veryLightGrey,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          Get.log(snapshot.error.toString());
          return Text("حدث خطأ ما المدينة ${snapshot.error.toString()}");
        }
        return Container(
          height: context.height * .5,
          width: context.width,
          alignment: Alignment.center,
          child: const CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation(ColorsManager.primary),
          ),
        );
      },
    );
  }
}
