class SingleRestaurantModel {
  SingleRestaurantModel({
    this.success,
    this.message,
    this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory SingleRestaurantModel.fromJson(Map<String, dynamic> json){
    return SingleRestaurantModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
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

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
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
  final double? commissionRate;
  final dynamic adminId;
  final dynamic updatedAt;
  final String? id;

  factory Commission.fromJson(Map<String, dynamic> json){
    return Commission(
      verified: json["verified"],
      commissionRate: (json["commissionRate"] as num?)?.toDouble(),
      adminId: json["adminId"],
      updatedAt: json["updatedAt"],
      id: json["_id"],
    );
  }

}

class Location {
  Location({
    required this.type,
    required this.coordinates,
  });

  final String? type;
  final List<double> coordinates;

  factory Location.fromJson(Map<String, dynamic> json){
    return Location(
      type: json["type"],
      coordinates: json["coordinates"] == null
          ? []
          : List<double>.from(json["coordinates"]!.map((x) => (x as num).toDouble())),
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
    required this.total,
  });

  final double? star;
  final int? total;

  factory Review.fromJson(Map<String, dynamic> json){
    return Review(
      star: (json["star"] as num?)?.toDouble(),
      total: json["total"],
    );
  }
}
