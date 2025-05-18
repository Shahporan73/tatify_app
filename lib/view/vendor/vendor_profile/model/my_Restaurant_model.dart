class MyRestaurantModel {
  MyRestaurantModel({
    this.success,
    this.message,
    this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory MyRestaurantModel.fromJson(Map<String, dynamic> json) {
    return MyRestaurantModel(
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
    required this.commission,
  });

  final Location? location;
  final Review? review;
  final String? id;
  final String? name;
  final VendorId? vendorId;
  final String? featureImage;
  final List<dynamic> images;
  final String? address;
  final String? city;
  final List<String> kitchenStyle;
  final List<OpeningHr> openingHr;
  final String? status;
  final Commission? commission;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      location: json["location"] == null ? null : Location.fromJson(json["location"]),
      review: json["review"] == null ? null : Review.fromJson(json["review"]),
      id: json["_id"],
      name: json["name"],
      vendorId: json["vendorId"] == null ? null : VendorId.fromJson(json["vendorId"]),
      featureImage: json["featureImage"],
      images: json["images"] == null ? [] : List<dynamic>.from(json["images"].map((x) => x)),
      address: json["address"],
      city: json["city"],
      kitchenStyle: json["kitchenStyle"] == null ? [] : List<String>.from(json["kitchenStyle"].map((x) => x)),
      openingHr: json["openingHr"] == null ? [] : List<OpeningHr>.from(json["openingHr"].map((x) => OpeningHr.fromJson(x))),
      status: json["status"],
      commission: json["commission"] == null ? null : Commission.fromJson(json["commission"]),
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
  final String? id;

  factory Commission.fromJson(Map<String, dynamic> json) {
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

  final String? day;
  final String? openTime;
  final String? closeTime;
  final bool? isClosed;
  final String? id;

  factory OpeningHr.fromJson(Map<String, dynamic> json) {
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

  final dynamic star;

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      star: json["star"],
    );
  }
}

class VendorId {
  VendorId({
    required this.id,
    required this.name,
  });

  final String? id;
  final String? name;

  factory VendorId.fromJson(Map<String, dynamic> json) {
    return VendorId(
      id: json["_id"],
      name: json["name"],
    );
  }
}
