class ReviewsModel {
  ReviewsModel({
    this.success,
    this.message,
    this.data,
  });

  final bool? success;
  final String? message;
  final List<ReviewList>? data;

  factory ReviewsModel.fromJson(Map<String, dynamic> json){
    return ReviewsModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? [] : List<ReviewList>.from(json["data"]!.map((x) => ReviewList.fromJson(x))),
    );
  }

}

class ReviewList {
  ReviewList({
    required this.id,
    required this.user,
    required this.foodId,
    required this.ratings,
    required this.createdAt,
    required this.updatedAt,
    required this.restaurantFood,
    required this.userInfo,
  });

  final String? id;
  final String? user;
  final String? foodId;
  final double? ratings;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final RestaurantFood? restaurantFood;
  final UserInfo? userInfo;

  factory ReviewList.fromJson(Map<String, dynamic> json){
    return ReviewList(
      id: json["_id"],
      user: json["user"],
      foodId: json["foodId"],
      ratings: json["ratings"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      restaurantFood: json["restaurantFood"] == null ? null : RestaurantFood.fromJson(json["restaurantFood"]),
      userInfo: json["userInfo"] == null ? null : UserInfo.fromJson(json["userInfo"]),
    );
  }

}

class RestaurantFood {
  RestaurantFood({
    required this.id,
  });

  final String? id;

  factory RestaurantFood.fromJson(Map<String, dynamic> json){
    return RestaurantFood(
      id: json["_id"],
    );
  }

}

class UserInfo {
  UserInfo({
    required this.id,
    required this.name,
    required this.profileImage,
    required this.email,
  });

  final String? id;
  final String? name;
  final dynamic profileImage;
  final String? email;

  factory UserInfo.fromJson(Map<String, dynamic> json){
    return UserInfo(
      id: json["_id"],
      name: json["name"],
      profileImage: json["profileImage"],
      email: json["email"],
    );
  }

}
