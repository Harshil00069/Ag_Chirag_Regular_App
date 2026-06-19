class ModifyOrderModel {
  final String clientcode;
  final String orderid;
  final String newPrice;
  final String quantity;
  final String variety;
  final String producttype;
  final String tradingsymbol;
  final String symboltoken;
  final String exchange;

  ModifyOrderModel({
    required this.clientcode,
    required this.orderid,
    required this.newPrice,
    required this.quantity,
    required this.variety,
    required this.producttype,
    required this.tradingsymbol,
    required this.symboltoken,
    required this.exchange,
  });

  factory ModifyOrderModel.fromJson(Map<String, dynamic> json) =>
      ModifyOrderModel(
        clientcode: json["clientcode"] ?? "",
        orderid: json["orderid"] ?? "",
        // Safely converts both string/numeric responses to String for your Node.js endpoint
        newPrice: json["newPrice"]?.toString() ?? "0.0",
        quantity: json["quantity"]?.toString() ?? "0",
        variety: json["variety"] ?? "NORMAL",
        producttype: json["producttype"] ?? "DELIVERY",
        tradingsymbol: json["tradingsymbol"] ?? "",
        symboltoken: json["symboltoken"] ?? "",
        exchange: json["exchange"] ?? "NSE",
      );

  Map<String, dynamic> toJson() =>
      {
        "clientcode": clientcode,
        "orderid": orderid,
        "newPrice": newPrice,
        "quantity": quantity,
        "variety": variety,
        "producttype": producttype,
        "tradingsymbol": tradingsymbol,
        "symboltoken": symboltoken,
        "exchange": exchange,
      };

}