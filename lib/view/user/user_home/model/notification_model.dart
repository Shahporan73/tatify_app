class NotificationModel {
  NotificationModel({
    this.success,
    this.message,
    this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory NotificationModel.fromJson(Map<String, dynamic> json){
    return NotificationModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.meta,
    required this.result,
  });

  final Meta? meta;
  final List<NotificationList> result;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      result: json["result"] == null ? [] : List<NotificationList>.from(json["result"]!.map((x) => NotificationList.fromJson(x))),
    );
  }

}

class Meta {
  Meta({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPage,
  });

  final int? page;
  final int? limit;
  final int? total;
  final int? totalPage;

  factory Meta.fromJson(Map<String, dynamic> json){
    return Meta(
      page: json["page"],
      limit: json["limit"],
      total: json["total"],
      totalPage: json["totalPage"],
    );
  }

}

class NotificationList {
  NotificationList({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.receiverEmail,
    required this.receiverRole,
    required this.type,
    required this.title,
    required this.message,
    required this.isRead,
    required this.link,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final dynamic sender;
  final Receiver? receiver;
  final dynamic receiverEmail;
  final String? receiverRole;
  final String? type;
  final String? title;
  final String? message;
  final bool? isRead;
  final dynamic link;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory NotificationList.fromJson(Map<String, dynamic> json){
    return NotificationList(
      id: json["_id"],
      sender: json["sender"],
      receiver: json["receiver"] == null ? null : Receiver.fromJson(json["receiver"]),
      receiverEmail: json["receiverEmail"],
      receiverRole: json["receiverRole"],
      type: json["type"],
      title: json["title"],
      message: json["message"],
      isRead: json["isRead"],
      link: json["link"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

}

class Receiver {
  Receiver({
    required this.id,
    required this.name,
    required this.email,
  });

  final String? id;
  final String? name;
  final String? email;

  factory Receiver.fromJson(Map<String, dynamic> json){
    return Receiver(
      id: json["_id"],
      name: json["name"],
      email: json["email"],
    );
  }

}
