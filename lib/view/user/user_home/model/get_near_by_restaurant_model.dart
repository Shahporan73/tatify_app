class GetNearByRestaurantModel {
  GetNearByRestaurantModel({
    this.success,
    this.message,
    this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory GetNearByRestaurantModel.fromJson(Map<String, dynamic> json){
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

  final int? limit;
  final dynamic distance;
  final List<RestaurantList> result;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      limit: json["limit"],
      distance: json["distance"],
      result: json["result"] == null ? [] : List<RestaurantList>.from(json["result"]!.map((x) => RestaurantList.fromJson(x))),
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
    required this.status,
    required this.isDeleted,
    required this.commission,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.distance,
    required this.vendorDetails,
  });

  final String? id;
  final String? name;
  final String? vendorId;
  final String? featureImage;
  final List<dynamic> images;
  final String? address;
  final String? city;
  final Location? location;
  final List<String> kitchenStyle;
  final List<OpeningHr> openingHr;
  final String? status;
  final bool? isDeleted;
  final Commission? commission;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final double? distance;
  final VendorDetails? vendorDetails;

  factory RestaurantList.fromJson(Map<String, dynamic> json){
    return RestaurantList(
      id: json["_id"],
      name: json["name"],
      vendorId: json["vendorId"],
      featureImage: json["featureImage"],
      images: json["images"] == null ? [] : List<dynamic>.from(json["images"]!.map((x) => x)),
      address: json["address"],
      city: json["city"],
      location: json["location"] == null ? null : Location.fromJson(json["location"]),
      kitchenStyle: json["kitchenStyle"] == null ? [] : List<String>.from(json["kitchenStyle"]!.map((x) => x)),
      openingHr: json["openingHr"] == null ? [] : List<OpeningHr>.from(json["openingHr"]!.map((x) => OpeningHr.fromJson(x))),
      status: json["status"],
      isDeleted: json["isDeleted"],
      commission: json["commission"] == null ? null : Commission.fromJson(json["commission"]),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      distance: json["distance"],
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
  final int? commissionRate;
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

  factory Location.fromJson(Map<String, dynamic> json){
    return Location(
      coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x)),
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

class VendorDetails {
  VendorDetails({
    required this.id,
    required this.location,
  });

  final String? id;
  final Location? location;

  factory VendorDetails.fromJson(Map<String, dynamic> json){
    return VendorDetails(
      id: json["_id"],
      location: json["location"] == null ? null : Location.fromJson(json["location"]),
    );
  }

}
