class FoodItemModel {
  FoodItemModel({
    this.success,
    this.message,
    this.data,
  });

  final bool? success;
  final dynamic message;
  final Data? data;

  factory FoodItemModel.fromJson(Map<dynamic, dynamic> json){
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

  factory Data.fromJson(Map<dynamic, dynamic> json){
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

  final dynamic page;
  final dynamic limit;
  final dynamic total;
  final dynamic totalPage;

  factory Meta.fromJson(Map<dynamic, dynamic> json){
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

  final dynamic id;
  final dynamic itemName;
  final List<dynamic> itemPhoto;
  final dynamic vendor;
  final dynamic description;
  final Price? price;
  final Restaurant? restaurant;
  final List<dynamic> ratings;
  final dynamic status;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory FoodList.fromJson(Map<dynamic, dynamic> json){
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

  final dynamic price;
  final dynamic discountPrice;
  final dynamic offerDay;
  final dynamic specificOfferDay;
  final dynamic id;

  factory Price.fromJson(Map<dynamic, dynamic> json){
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
    required this.location,
    required this.review,
    required this.id,
    required this.name,
    required this.vendorId,
    required this.featureImage,
    required this.images,
    required this.address,
    required this.city,
    required this.kitchenStyle,
    required this.openingHr,
    required this.status,
    required this.isDeleted,
    required this.commission,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final Location? location;
  final Review? review;
  final dynamic id;
  final dynamic name;
  final dynamic vendorId;
  final dynamic featureImage;
  final List<dynamic> images;
  final dynamic address;
  final dynamic city;
  final List<dynamic> kitchenStyle;
  final List<OpeningHr> openingHr;
  final dynamic status;
  final bool? isDeleted;
  final Commission? commission;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic v;

  factory Restaurant.fromJson(Map<dynamic, dynamic> json){
    return Restaurant(
      location: json["location"] == null ? null : Location.fromJson(json["location"]),
      review: json["review"] == null ? null : Review.fromJson(json["review"]),
      id: json["_id"],
      name: json["name"],
      vendorId: json["vendorId"],
      featureImage: json["featureImage"],
      images: json["images"] == null ? [] : List<dynamic>.from(json["images"]!.map((x) => x)),
      address: json["address"],
      city: json["city"],
      kitchenStyle: json["kitchenStyle"] == null ? [] : List<dynamic>.from(json["kitchenStyle"]!.map((x) => x)),
      openingHr: json["openingHr"] == null ? [] : List<OpeningHr>.from(json["openingHr"]!.map((x) => OpeningHr.fromJson(x))),
      status: json["status"],
      isDeleted: json["isDeleted"],
      commission: json["commission"] == null ? null : Commission.fromJson(json["commission"]),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

}

class Commission {
  Commission({
    required this.verified,
    required this.commissionRate,
    required this.adminId,
    required this.updatedAt,
    required this.id,
  });

  final bool? verified;
  final dynamic commissionRate;
  final dynamic adminId;
  final dynamic updatedAt;
  final dynamic id;

  factory Commission.fromJson(Map<dynamic, dynamic> json){
    return Commission(
      verified: json["verified"],
      commissionRate: json["commissionRate"],
      adminId: json["adminId"],
      updatedAt: json["updatedAt"],
      id: json["_id"],
    );
  }

}

class Location {
  Location({
    required this.coordinates,
    required this.type,
  });

  final List<double> coordinates;
  final dynamic type;

  factory Location.fromJson(Map<dynamic, dynamic> json) {
    return Location(
      coordinates: json["coordinates"] == null
          ? []
          : List<double>.from(json["coordinates"].map((x) => (x as num).toDouble())),
      type: json["type"],
    );
  }
}


class OpeningHr {
  OpeningHr({
    required this.day,
    required this.openTime,
    required this.closeTime,
    required this.isClosed,
    required this.id,
  });

  final dynamic day;
  final dynamic openTime;
  final dynamic closeTime;
  final bool? isClosed;
  final dynamic id;

  factory OpeningHr.fromJson(Map<dynamic, dynamic> json){
    return OpeningHr(
      day: json["day"],
      openTime: json["openTime"],
      closeTime: json["closeTime"],
      isClosed: json["isClosed"],
      id: json["_id"],
    );
  }

}

class Review {
  Review({
    required this.star,
    required this.total,
  });

  final dynamic star;
  final dynamic total;

  factory Review.fromJson(Map<dynamic, dynamic> json){
    return Review(
      star: json["star"],
      total: json["total"],
    );
  }
}
