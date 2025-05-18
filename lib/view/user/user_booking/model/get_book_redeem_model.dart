class GetBookRedeemModel {
  GetBookRedeemModel({
    this.success,
    this.message,
    this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory GetBookRedeemModel.fromJson(Map<String, dynamic> json){
    return GetBookRedeemModel(
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
  final List<BookingList> data;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      data: json["data"] == null ? [] : List<BookingList>.from(json["data"]!.map((x) => BookingList.fromJson(x))),
    );
  }

}

class BookingList {
  BookingList({
    required this.id,
    required this.user,
    required this.vendor,
    required this.food,
    required this.restaurant,
    required this.cash,
    required this.isDeleted,
    required this.userRedeem,
    required this.vendorRedeem,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final User? user;
  final String? vendor;
  final Food? food;
  final Restaurant? restaurant;
  final Cash? cash;
  final bool? isDeleted;
  final RRedeem? userRedeem;
  final RRedeem? vendorRedeem;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory BookingList.fromJson(Map<String, dynamic> json){
    return BookingList(
      id: json["_id"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      vendor: json["vendor"],
      food: json["food"] == null ? null : Food.fromJson(json["food"]),
      restaurant: json["restaurant"] == null ? null : Restaurant.fromJson(json["restaurant"]),
      cash: json["cash"] == null ? null : Cash.fromJson(json["cash"]),
      isDeleted: json["isDeleted"],
      userRedeem: json["userRedeem"] == null ? null : RRedeem.fromJson(json["userRedeem"]),
      vendorRedeem: json["vendorRedeem"] == null ? null : RRedeem.fromJson(json["vendorRedeem"]),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

}

class Cash {
  Cash({
    required this.regularPrice,
    required this.payableAmount,
    required this.commissionRate,
    required this.id,
  });

  final int? regularPrice;
  final int? payableAmount;
  final int? commissionRate;
  final String? id;

  factory Cash.fromJson(Map<String, dynamic> json){
    return Cash(
      regularPrice: json["regularPrice"],
      payableAmount: json["payableAmount"],
      commissionRate: json["commissionRate"],
      id: json["_id"],
    );
  }

}

class Food {
  Food({
    required this.id,
    required this.itemName,
    required this.itemPhoto,
    required this.description,
  });

  final String? id;
  final String? itemName;
  final List<dynamic> itemPhoto;
  final String? description;

  factory Food.fromJson(Map<String, dynamic> json){
    return Food(
      id: json["_id"],
      itemName: json["itemName"],
      itemPhoto: json["itemPhoto"] == null ? [] : List<dynamic>.from(json["itemPhoto"]!.map((x) => x)),
      description: json["description"],
    );
  }

}

class Restaurant {
  Restaurant({
    required this.id,
    required this.address,
  });

  final String? id;
  final String? address;

  factory Restaurant.fromJson(Map<String, dynamic> json){
    return Restaurant(
      id: json["_id"],
      address: json["address"],
    );
  }

}

class User {
  User({
    required this.id,
    required this.name,
    required this.profileImage,
    required this.phoneNumber,
    required this.email,
  });

  final String? id;
  final String? name;
  final String? profileImage;
  final String? phoneNumber;
  final String? email;

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json["_id"],
      name: json["name"],
      profileImage: json["profileImage"],
      phoneNumber: json["phoneNumber"],
      email: json["email"],
    );
  }

}

class RRedeem {
  RRedeem({
    required this.redeemStatus,
    required this.redeemDate,
    required this.id,
  });

  final String? redeemStatus;
  final DateTime? redeemDate;
  final String? id;

  factory RRedeem.fromJson(Map<String, dynamic> json){
    return RRedeem(
      redeemStatus: json["redeemStatus"],
      redeemDate: DateTime.tryParse(json["redeemDate"] ?? ""),
      id: json["_id"],
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
