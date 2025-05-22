class GetNearByRestaurantModel {
  GetNearByRestaurantModel({
    this.success,
    this.message,
    this.data,
  });

  final bool? success;
  final dynamic message;
  final Data? data;

  factory GetNearByRestaurantModel.fromJson(Map<dynamic, dynamic> json) {
    return GetNearByRestaurantModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}

class Data {
  Data({
    required this.limit,
    required this.distance,
    required this.result,
  });

  final dynamic? limit;
  final double? distance;
  final List<RestaurantList> result;

  factory Data.fromJson(Map<dynamic, dynamic> json) {
    return Data(
      limit: json["limit"],
      distance: json["distance"] == null ? null : (json["distance"] as num).toDouble(),
      result: json["result"] == null
          ? []
          : List<RestaurantList>.from(json["result"]!.map((x) => RestaurantList.fromJson(x))),
    );
  }
}

class RestaurantList {
  RestaurantList({
    required this.id,
    required this.name,
    required this.vendorId,
    required this.featureImage,
    required this.images,
    required this.address,
    required this.city,
    required this.location,
    required this.kitchenStyle,
    required this.openingHr,
    required this.review,
    required this.status,
    required this.isDeleted,
    required this.commission,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.distance,
    required this.vendorDetails,
  });

  final dynamic id;
  final dynamic name;
  final dynamic vendorId;
  final dynamic featureImage;
  final List<dynamic> images;
  final dynamic address;
  final dynamic city;
  final Location? location;
  final List<dynamic> kitchenStyle;
  final List<OpeningHr> openingHr;
  final Review? review;
  final dynamic status;
  final bool? isDeleted;
  final Commission? commission;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic? v;
  final double? distance;
  final VendorDetails? vendorDetails;

  factory RestaurantList.fromJson(Map<dynamic, dynamic> json) {
    return RestaurantList(
      id: json["_id"],
      name: json["name"],
      vendorId: json["vendorId"],
      featureImage: json["featureImage"],
      images: json["images"] == null ? [] : List<dynamic>.from(json["images"]!.map((x) => x)),
      address: json["address"],
      city: json["city"],
      location: json["location"] == null ? null : Location.fromJson(json["location"]),
      kitchenStyle: json["kitchenStyle"] == null ? [] : List<dynamic>.from(json["kitchenStyle"]!.map((x) => x)),
      openingHr: json["openingHr"] == null ? [] : List<OpeningHr>.from(json["openingHr"]!.map((x) => OpeningHr.fromJson(x))),
      review: json["review"] == null ? null : Review.fromJson(json["review"]),
      status: json["status"],
      isDeleted: json["isDeleted"],
      commission: json["commission"] == null ? null : Commission.fromJson(json["commission"]),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      distance: json["distance"] == null ? null : (json["distance"] as num).toDouble(),
      vendorDetails: json["vendorDetails"] == null ? null : VendorDetails.fromJson(json["vendorDetails"]),
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
  final dynamic? commissionRate;
  final dynamic adminId;
  final dynamic updatedAt;
  final dynamic id;

  factory Commission.fromJson(Map<dynamic, dynamic> json) {
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
    required this.type,
    required this.coordinates,
  });

  final dynamic type;
  final List<double> coordinates;

  factory Location.fromJson(Map<dynamic, dynamic> json) {
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

  final dynamic day;
  final dynamic openTime;
  final dynamic closeTime;
  final bool? isClosed;
  final dynamic id;

  factory OpeningHr.fromJson(Map<dynamic, dynamic> json) {
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
  final dynamic? total;

  factory Review.fromJson(Map<dynamic, dynamic> json) {
    return Review(
      star: json["star"] == null ? null : (json["star"] as num).toDouble(),
      total: json["total"],
    );
  }
}

class VendorDetails {
  VendorDetails({
    required this.id,
    required this.name,
    required this.profileImage,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.role,
    required this.gender,
    required this.dob,
    required this.fcmToken,
    required this.address,
    required this.location,
    required this.isLocationUpdated,
    required this.status,
    required this.isDeleted,
    required this.verification,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.passwordChangedAt,
  });

  final dynamic id;
  final dynamic name;
  final dynamic profileImage;
  final dynamic phoneNumber;
  final dynamic email;
  final dynamic password;
  final dynamic role;
  final dynamic gender;
  final DateTime? dob;
  final dynamic fcmToken;
  final dynamic address;
  final Location? location;
  final bool? isLocationUpdated;
  final dynamic status;
  final bool? isDeleted;
  final Verification? verification;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic? v;
  final DateTime? passwordChangedAt;

  factory VendorDetails.fromJson(Map<dynamic, dynamic> json) {
    return VendorDetails(
      id: json["_id"],
      name: json["name"],
      profileImage: json["profileImage"],
      phoneNumber: json["phoneNumber"],
      email: json["email"],
      password: json["password"],
      role: json["role"],
      gender: json["gender"],
      dob: DateTime.tryParse(json["dob"] ?? ""),
      fcmToken: json["fcmToken"],
      address: json["address"],
      location: json["location"] == null ? null : Location.fromJson(json["location"]),
      isLocationUpdated: json["isLocationUpdated"],
      status: json["status"],
      isDeleted: json["isDeleted"],
      verification: json["verification"] == null ? null : Verification.fromJson(json["verification"]),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      passwordChangedAt: DateTime.tryParse(json["passwordChangedAt"] ?? ""),
    );
  }
}

class Verification {
  Verification({
    required this.verified,
    required this.otp,
    required this.id,
  });

  final bool? verified;
  final dynamic otp;
  final dynamic id;

  factory Verification.fromJson(Map<dynamic, dynamic> json) {
    return Verification(
      verified: json["verified"],
      otp: json["otp"],
      id: json["_id"],
    );
  }
}
