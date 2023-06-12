class RegionsModel {
  bool? status;
  String? message;
  List<RegionModel>? data;

  RegionsModel({this.status, this.message, this.data});

  RegionsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <RegionModel>[];
      json['data'].forEach((v) {
        data!.add(RegionModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RegionModel {
  int? id;
  String? name;

  RegionModel({this.id, this.name});

  RegionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  @override
  String toString() => 'RegionModel(id: $id, name: $name)';
}
