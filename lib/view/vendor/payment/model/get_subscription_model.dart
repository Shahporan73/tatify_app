class GetSubscriptionModel {
  GetSubscriptionModel({
    this.success,
    this.message,
    this.data,
  });

  final bool? success;
  final String? message;
  final List<SubscriptionList>? data;

  factory GetSubscriptionModel.fromJson(Map<String, dynamic> json){
    return GetSubscriptionModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? [] : List<SubscriptionList>.from(json["data"]!.map((x) => SubscriptionList.fromJson(x))),
    );
  }

}

class SubscriptionList {
  SubscriptionList({
    required this.duration,
    required this.id,
    required this.name,
    required this.description,
    required this.amount,
    required this.currency,
    required this.status,
    required this.v,
  });

  final SubDuration? duration;
  final String? id;
  final String? name;
  final String? description;
  final double? amount;
  final String? currency;
  final String? status;
  final int? v;

  factory SubscriptionList.fromJson(Map<String, dynamic> json){
    return SubscriptionList(
      duration: json["duration"] == null ? null : SubDuration.fromJson(json["duration"]),
      id: json["_id"],
      name: json["name"],
      description: json["description"],
      amount: json["amount"],
      currency: json["currency"],
      status: json["status"],
      v: json["__v"],
    );
  }

}

class SubDuration {
  SubDuration({
    required this.count,
    required this.durationType,
  });

  final int? count;
  final String? durationType;

  factory SubDuration.fromJson(Map<String, dynamic> json){
    return SubDuration(
      count: json["count"],
      durationType: json["durationType"],
    );
  }

}
