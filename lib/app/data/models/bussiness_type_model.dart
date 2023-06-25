class BussinessTypeModel {
  final int id;
  final String title;

  BussinessTypeModel({
    required this.id,
    required this.title,
  });
}

List<BussinessTypeModel> bussinessTypeList = [
  BussinessTypeModel(id: 1, title: "تجاري"),
  BussinessTypeModel(id: 2, title: "عقارى"),
  BussinessTypeModel(id: 3, title: "تقني"),
  BussinessTypeModel(id: 4, title: "أراضى"),
  BussinessTypeModel(id: 5, title: "اخرى"),
];
