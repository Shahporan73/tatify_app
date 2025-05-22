class TotalCommissionModel {
  TotalCommissionModel({
    this.success,
    this.message,
    this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory TotalCommissionModel.fromJson(Map<String, dynamic> json){
    return TotalCommissionModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.year,
    required this.totalCommission,
    required this.items,
  });

  final int? year;
  final int? totalCommission;
  final List<CommissionList> items;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      year: json["year"],
      totalCommission: json["totalCommission"],
      items: json["items"] == null ? [] : List<CommissionList>.from(json["items"]!.map((x) => CommissionList.fromJson(x))),
    );
  }

}

class CommissionList {
  CommissionList({
    required this.month,
    required this.monthName,
    required this.totalPrice,
    required this.totalSale,
    required this.totalCommission,
    required this.totalNetIncome,
  });

  final int? month;
  final String? monthName;
  final int? totalPrice;
  final int? totalSale;
  final int? totalCommission;
  final int? totalNetIncome;

  factory CommissionList.fromJson(Map<String, dynamic> json){
    return CommissionList(
      month: json["month"],
      monthName: json["monthName"],
      totalPrice: json["totalPrice"],
      totalSale: json["totalSale"],
      totalCommission: json["totalCommission"],
      totalNetIncome: json["totalNetIncome"],
    );
  }

}
