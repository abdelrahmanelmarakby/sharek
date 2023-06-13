class ServiceTypeModel {
  int? serviceTypeId;
  String? name;

  ServiceTypeModel({this.serviceTypeId, this.name});

  ServiceTypeModel.fromJson(Map<String, dynamic> json) {
    serviceTypeId = json["service_type_id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["service_type_id"] = serviceTypeId;
    data["name"] = name;
    return data;
  }
}

List<ServiceTypeModel> businessServicesTypes = [
  ServiceTypeModel(name: "بحث عن شريك", serviceTypeId: 1),
  ServiceTypeModel(name: "إعلان البائعين", serviceTypeId: 2),
  ServiceTypeModel(name: "فرنشايز", serviceTypeId: 4),
  ServiceTypeModel(name: "محاماة", serviceTypeId: 5),
  ServiceTypeModel(name: "خدمات اخرى", serviceTypeId: 3),
];
List<ServiceTypeModel> tripServicesTypes = [
  ServiceTypeModel(name: "راكب", serviceTypeId: 6),
  ServiceTypeModel(name: "سائق", serviceTypeId: 7),
];
List<ServiceTypeModel> sacrificeServicesTypes = [
  ServiceTypeModel(name: "بحث عن شريك", serviceTypeId: 8),
  ServiceTypeModel(name: "اعلان بيع", serviceTypeId: 9),
];
List<ServiceTypeModel> houseServicesTypes = [
  ServiceTypeModel(name: "بحث عن شريك", serviceTypeId: 10),
  ServiceTypeModel(name: "شقق الإيجار", serviceTypeId: 11),
];
