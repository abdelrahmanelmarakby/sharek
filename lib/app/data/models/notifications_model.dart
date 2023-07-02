// ignore_for_file: no_leading_underscores_for_local_identifiers

class NotificationsModel {
  bool? status;
  String? message;
  List<Data>? data;

  NotificationsModel({this.status, this.message, this.data});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? userId;
  int? senderId;
  String? title;
  String? content;
  String? type;
  int? advertisementId;
  int? isRead;
  String? avatar;
  String? createdAt;

  Data(
      {this.id,
      this.userId,
      this.senderId,
      this.title,
      this.content,
      this.type,
      this.advertisementId,
      this.isRead,
      this.avatar,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["user_id"] is int) {
      userId = json["user_id"];
    }
    if (json["sender_id"] is int) {
      senderId = json["sender_id"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["content"] is String) {
      content = json["content"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["advertisement_id"] is int) {
      advertisementId = json["advertisement_id"];
    }
    if (json["is_read"] is int) {
      isRead = json["is_read"];
    }
    if (json["avatar"] is String) {
      avatar = json["avatar"];
    }
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["user_id"] = userId;
    _data["sender_id"] = senderId;
    _data["title"] = title;
    _data["content"] = content;
    _data["type"] = type;
    _data["advertisement_id"] = advertisementId;
    _data["is_read"] = isRead;
    _data["avatar"] = avatar;
    _data["created_at"] = createdAt;
    return _data;
  }
}
