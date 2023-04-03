// ignore_for_file: no_leading_underscores_for_local_identifiers

class TripServiceTypeModel {
  bool? status;
  String? message;
  List<Data>? data;

  TripServiceTypeModel({this.status, this.message, this.data});

  TripServiceTypeModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] == null
        ? null
        : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["message"] = message;
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Data {
  int? serviceTypeId;
  String? name;

  Data({this.serviceTypeId, this.name});

  Data.fromJson(Map<String, dynamic> json) {
    serviceTypeId = json["service_type_id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["service_type_id"] = serviceTypeId;
    _data["name"] = name;
    return _data;
  }
}
