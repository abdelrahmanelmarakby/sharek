import 'package:flutter/material.dart';
import 'package:sharek/core/constants/theme/theme_export.dart';
import 'package:sharek/core/extensions/export.dart';

class CustomDropList extends StatefulWidget {
  final bool? check;

  final Function? onChanged;

  final List<DropListModel>? list;
  final DropListModel? initialValue;
  final bool isHeader;

  final double? height;
  final Color? backColor;

  final double? width;

  final bool? bottomBorder;

  final String? headerText;

  const CustomDropList(
      {Key? key,
      this.check,
      this.onChanged,
      this.list,
      this.isHeader = true,
      this.backColor,
      this.width,
      this.headerText,
      this.height,
      this.bottomBorder,
      this.initialValue})
      : super(key: key);

  @override
  State<CustomDropList> createState() => _CustomDropListState();
}

/// This is the private State class that goes with CustomDropList.
class _CustomDropListState extends State<CustomDropList> {
  DropListModel? dropdownValue =
      DropListModel(name: "", code: "", image: null, id: 0, preferredName: "");

  @override
  void initState() {
    if (widget.initialValue != null) {
      dropdownValue = widget.initialValue;
      widget.onChanged!(dropdownValue);
    } else if (widget.list!.isNotEmpty) {
      dropdownValue = widget.list![0];
      widget.onChanged!(dropdownValue);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.isHeader ? 4 : 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   widget.headerText ?? allTranslations.text("choose_complain"),
          //   style: TextStyle(
          //       fontWeight: FontWeight.w500, fontSize: widget.fontSize ?? 15),
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              width: widget.width ?? MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(
                  horizontal: widget.width != null ? 0 : 5),
              height: widget.height ?? 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: context.isDarkMode
                    ? ColorsManager.darkGrey
                    : ColorsManager.lightGrey,
                border: Border.all(
                    // color: (mainAppBloc.theme.valueOrNull!
                    //         ? MyColors.darkStroke_2
                    //         : MyColors.lightStroke)
                    //     .withOpacity(0.5)
                    ),
                // borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton<DropListModel>(
                // dropdownColor: (mainAppBloc.theme.valueOrNull!
                //         ? MyColors.cardBackground
                //         : MyColors.lightBackground_2)
                //.withOpacity(0.5),
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                hint: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: widget.isHeader ? 0 : 10),
                  child: Row(
                    children: [
                      dropdownValue!.image != null
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Image.asset(
                                  'assets/flags/${dropdownValue!.image!.toLowerCase()}.png',
                                  height: 30,
                                  width: 30),
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          dropdownValue != null ? dropdownValue!.name! : "",
                          style: StylesManager.regular(
                            fontSize: FontSize.large,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                underline: Container(
                  height: 2,
                  color: Colors.transparent,
                ),
                isExpanded: true,
                onChanged: (DropListModel? newValue) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  setState(() {
                    dropdownValue = newValue;
                  });
                  widget.onChanged!(dropdownValue);
                },
                items: widget.list!.map((DropListModel value) {
                  return DropdownMenuItem<DropListModel>(
                    value: value,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 40,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                value.image != null
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: Image.asset(
                                            'assets/flags/${value.image!.toLowerCase()}.png',
                                            height: 30,
                                            width: 30),
                                      )
                                    : Container(),
                                Text(
                                  value.name!,
                                  style: StylesManager.regular(
                                      fontSize: FontSize.large),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Visibility(
                              visible: value != widget.list!.last,
                              child: Container(
                                height: 1,
                                width: MediaQuery.of(context).size.width - 30,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DropListModel {
  final int? id;
  final String? name;
  final String? code;
  final String? preferredName;
  final String? timezone;
  final String? image;
  final String? prefixCode;
  final double? lat;
  final double? long;

  DropListModel(
      {this.id,
      this.prefixCode,
      this.lat,
      this.long,
      this.timezone,
      this.name,
      this.code,
      this.preferredName,
      this.image});
}
