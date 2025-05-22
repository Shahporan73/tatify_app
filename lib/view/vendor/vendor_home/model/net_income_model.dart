class NetIncomeModel {
  NetIncomeModel({
     this.success,
    this.message,
    this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory NetIncomeModel.fromJson(Map<String, dynamic> json){
    return NetIncomeModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.date,
    required this.totalNetIncome,
    required this.items,
  });

  final String? date;
  final int? totalNetIncome;
  final List<NetIncomeList> items;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      date: json["date"],
      totalNetIncome: json["totalNetIncome"],
      items: json["items"] == null ? [] : List<NetIncomeList>.from(json["items"]!.map((x) => NetIncomeList.fromJson(x))),
    );
  }

}

class NetIncomeList {
  NetIncomeList({
    required this.id,
    required this.totalPrice,
    required this.totalSale,
    required this.rate,
    required this.itemNetIncome,
    required this.foodName,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final int? totalPrice;
  final int? totalSale;
  final int? rate;
  final int? itemNetIncome;
  final String? foodName;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory NetIncomeList.fromJson(Map<String, dynamic> json){
    return NetIncomeList(
      id: json["_id"],
      totalPrice: json["totalPrice"],
      totalSale: json["totalSale"],
      rate: json["rate"],
      itemNetIncome: json["itemNetIncome"],
      foodName: json["foodName"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

}
