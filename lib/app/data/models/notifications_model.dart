class NotificationsModel {
  bool? status;
  String? message;
  List<Data>? data;

  NotificationsModel({this.status, this.message, this.data});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  String? title;
  String? content;
  int? isRead;
  String? avatar;
  String? createdAt;

  Data({this.title, this.content, this.isRead, this.avatar, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    isRead = json['is_read'];
    avatar = json['avatar'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['content'] = content;
    data['is_read'] = isRead;
    data['avatar'] = avatar;
    data['created_at'] = createdAt;
    return data;
  }
}
