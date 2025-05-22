class FoodItemModel {
  FoodItemModel({
    this.success,
    this.message,
    this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory FoodItemModel.fromJson(Map<String, dynamic> json){
    return FoodItemModel(
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
  final List<FoodList> result;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      result: json["result"] == null ? [] : List<FoodList>.from(json["result"]!.map((x) => FoodList.fromJson(x))),
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

class FoodList {
  FoodList({
    required this.id,
    required this.itemName,
    required this.itemPhoto,
    required this.vendor,
    required this.description,
    required this.price,
    required this.restaurant,
    required this.ratings,
    required this.status,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? itemName;
  final List<dynamic> itemPhoto;
  final String? vendor;
  final String? description;
  final Price? price;
  final Restaurant? restaurant;
  final List<dynamic> ratings;
  final String? status;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory FoodList.fromJson(Map<String, dynamic> json){
    return FoodList(
      id: json["_id"],
      itemName: json["itemName"],
      itemPhoto: json["itemPhoto"] == null ? [] : List<dynamic>.from(json["itemPhoto"]!.map((x) => x)),
      vendor: json["vendor"],
      description: json["description"],
      price: json["price"] == null ? null : Price.fromJson(json["price"]),
      restaurant: json["restaurant"] == null ? null : Restaurant.fromJson(json["restaurant"]),
      ratings: json["ratings"] == null ? [] : List<dynamic>.from(json["ratings"]!.map((x) => x)),
      status: json["status"],
      isDeleted: json["isDeleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

}

class Price {
  Price({
    required this.price,
    required this.discountPrice,
    required this.offerDay,
    required this.specificOfferDay,
    required this.id,
  });

  final int? price;
  final int? discountPrice;
  final String? offerDay;
  final String? specificOfferDay;
  final String? id;

  factory Price.fromJson(Map<String, dynamic> json){
    return Price(
      price: json["price"],
      discountPrice: json["discountPrice"],
      offerDay: json["offerDay"],
      specificOfferDay: json["specificOfferDay"],
      id: json["_id"],
    );
  }

}

class Restaurant {
  Restaurant({
    required this.id,
    required this.name,
    required this.openingHr,
  });

  final String? id;
  final String? name;
  final List<OpeningHr> openingHr;

  factory Restaurant.fromJson(Map<String, dynamic> json){
    return Restaurant(
      id: json["_id"],
      name: json["name"],
      openingHr: json["openingHr"] == null ? [] : List<OpeningHr>.from(json["openingHr"]!.map((x) => OpeningHr.fromJson(x))),
    );
  }

}

class OpeningHr {
  OpeningHr({
    required this.day,
    required this.isClosed,
  });

  final String? day;
  final bool? isClosed;

  factory OpeningHr.fromJson(Map<String, dynamic> json){
    return OpeningHr(
      day: json["day"],
      isClosed: json["isClosed"],
    );
  }

}
