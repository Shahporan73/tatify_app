class FavoriteRestaurantModel {
  FavoriteRestaurantModel({
    this.success,
    this.message,
    this.data,
  });

  final bool? success;
  final String? message;
  final List<Fav_restaurant_list>? data;

  factory FavoriteRestaurantModel.fromJson(Map<String, dynamic> json){
    return FavoriteRestaurantModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? [] : List<Fav_restaurant_list>.from(json["data"]!.map((x) => Fav_restaurant_list.fromJson(x))),
    );
  }

}

class Fav_restaurant_list {
  Fav_restaurant_list({
    required this.id,
    required this.user,
    required this.restaurant,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? user;
  final Restaurant? restaurant;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Fav_restaurant_list.fromJson(Map<String, dynamic> json){
    return Fav_restaurant_list(
      id: json["_id"],
      user: json["user"],
      restaurant: json["restaurant"] == null ? null : Restaurant.fromJson(json["restaurant"]),
      isDeleted: json["isDeleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
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
  final String? id;
  final String? name;
  final String? vendorId;
  final String? featureImage;
  final List<dynamic> images;
  final String? address;
  final String? city;
  final List<String> kitchenStyle;
  final List<OpeningHr> openingHr;
  final String? status;
  final bool? isDeleted;
  final Commission? commission;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Restaurant.fromJson(Map<String, dynamic> json){
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
      kitchenStyle: json["kitchenStyle"] == null ? [] : List<String>.from(json["kitchenStyle"]!.map((x) => x)),
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
  final num? commissionRate;
  final dynamic adminId;
  final dynamic updatedAt;
  final String? id;

  factory Commission.fromJson(Map<String, dynamic> json){
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
  final String? type;

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      coordinates: json["coordinates"] == null
          ? []
          : List<double>.from(json["coordinates"]!.map((x) => (x as num).toDouble())),
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

  final String? day;
  final String? openTime;
  final String? closeTime;
  final bool? isClosed;
  final String? id;

  factory OpeningHr.fromJson(Map<String, dynamic> json){
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
  });

  final num? star;

  factory Review.fromJson(Map<String, dynamic> json){
    return Review(
      star: json["star"],
    );
  }
}

