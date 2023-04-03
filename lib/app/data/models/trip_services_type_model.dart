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
List<ServiceTypeModel> tripServicesTypes = [
  ServiceTypeModel(
    name: "راكب",
    serviceTypeId: 6
  ),
   ServiceTypeModel(
    name: "سائق",
    serviceTypeId: 7
  ),
];
