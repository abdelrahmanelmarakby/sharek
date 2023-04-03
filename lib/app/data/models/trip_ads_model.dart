// ignore_for_file: no_leading_underscores_for_local_identifiers

class TripAdvertisementsModel {
  bool? status;
  String? message;
  List<Data>? data;

  TripAdvertisementsModel({this.status, this.message, this.data});

  TripAdvertisementsModel.fromJson(Map<String, dynamic> json) {
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
    advertisementId = json["advertisement_id"];
    userId = json["user_id"];
    serviceTypeId = json["service_type_id"];
    startingPlace = json["starting_place"];
    endingPlace = json["ending_place"];
    title = json["title"];
    numberPassengers = json["number_passengers"];
    date = json["date"];
    time = json["time"];
    price = json["price"];
    withPackages = json["with_packages"];
    phone = json["phone"];
    carType = json["car_type"];
    userName = json["user_name"];
    createdAt1 = json["created_at_1"];
    createdAt2 = json["created_at_2"];
    photos = json["photos"] == null ? null : List<String>.from(json["photos"]);
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
