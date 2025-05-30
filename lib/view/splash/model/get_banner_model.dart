class GetBannerModel {
  GetBannerModel({
    this.success,
    this.message,
    this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory GetBannerModel.fromJson(Map<String, dynamic> json){
    return GetBannerModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.meta,
    required this.data,
  });

  final Meta? meta;
  final List<BannerList> data;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      data: json["data"] == null ? [] : List<BannerList>.from(json["data"]!.map((x) => BannerList.fromJson(x))),
    );
  }

}

class BannerList {
  BannerList({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? title;
  final String? description;
  final String? image;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory BannerList.fromJson(Map<String, dynamic> json){
    return BannerList(
      id: json["_id"],
      title: json["title"],
      description: json["description"],
      image: json["image"],
      isDeleted: json["isDeleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
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
