// ignore_for_file: no_leading_underscores_for_local_identifiers, unnecessary_type_check

class TripAdvertisementsModel {
  bool? status;
  String? message;
  List<Data>? data;

  TripAdvertisementsModel({this.status, this.message, this.data});

  TripAdvertisementsModel.fromJson(Map<String, dynamic> json) {
    if (json["status"] is bool) {
      status = json["status"];
    }
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["data"] is List) {
      data = json["data"] == null
          ? null
          : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
    }
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
  int? advertisementId;
  int? userId;
  int? serviceTypeId;
  String? startingPlace;
  String? endingPlace;
  String? title;
  int? numberPassengers;
  String? date;
  String? time;
  double? price;
  bool? withPackages;
  int? phone;
  String? carType;
  String? userName;
  String? createdAt1;
  String? createdAt2;
  List<String>? photos;

  Data(
      {this.advertisementId,
      this.userId,
      this.serviceTypeId,
      this.startingPlace,
      this.endingPlace,
      this.title,
      this.numberPassengers,
      this.date,
      this.time,
      this.price,
      this.withPackages,
      this.phone,
      this.carType,
      this.userName,
      this.createdAt1,
      this.createdAt2,
      this.photos});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["advertisement_id"] is int) {
      advertisementId = json["advertisement_id"];
    }
    if (json["user_id"] is int) {
      userId = json["user_id"];
    }
    if (json["service_type_id"] is int) {
      serviceTypeId = json["service_type_id"];
    }
    if (json["starting_place"] is String) {
      startingPlace = json["starting_place"];
    }
    if (json["ending_place"] is String) {
      endingPlace = json["ending_place"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["number_passengers"] is int) {
      numberPassengers = json["number_passengers"];
    }
    if (json["date"] is String) {
      date = json["date"];
    }
    if (json["time"] is String) {
      time = json["time"];
    }
    if (json["price"] is double) {
      price = json["price"];
    }
    if (json["with_packages"] is bool) {
      withPackages = json["with_packages"];
    }
    if (json["phone"] is int) {
      phone = json["phone"];
    }
    if (json["car_type"] is String) {
      carType = json["car_type"];
    }
    if (json["user_name"] is String) {
      userName = json["user_name"];
    }
    if (json["created_at_1"] is String) {
      createdAt1 = json["created_at_1"];
    }
    if (json["created_at_2"] is String) {
      createdAt2 = json["created_at_2"];
    }
    if (json["photos"] is List) {
      photos =
          json["photos"] == null ? null : List<String>.from(json["photos"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["advertisement_id"] = advertisementId;
    _data["user_id"] = userId;
    _data["service_type_id"] = serviceTypeId;
    _data["starting_place"] = startingPlace;
    _data["ending_place"] = endingPlace;
    _data["title"] = title;
    _data["number_passengers"] = numberPassengers;
    _data["date"] = date;
    _data["time"] = time;
    _data["price"] = price;
    _data["with_packages"] = withPackages;
    _data["phone"] = phone;
    _data["car_type"] = carType;
    _data["user_name"] = userName;
    _data["created_at_1"] = createdAt1;
    _data["created_at_2"] = createdAt2;
    if (photos != null) {
      _data["photos"] = photos;
    }
    return _data;
  }
}
