class PlaceOrderModel {
  final String clientcode;
  final String variety;
  final String tradingsymbol;
  final String symboltoken;
  final String transactiontype;
  final String exchange;
  final String ordertype;
  final String producttype;
  final String duration;
  final String price;
  final String quantity;

  PlaceOrderModel({
    required this.clientcode,
    required this.variety,
    required this.tradingsymbol,
    required this.symboltoken,
    required this.transactiontype,
    required this.exchange,
    required this.ordertype,
    required this.producttype,
    required this.duration,
    required this.price,
    required this.quantity,
  });

  factory PlaceOrderModel.fromJson(Map<String, dynamic> json) =>
      PlaceOrderModel(
        clientcode: json["clientcode"] ?? "",
        variety: json["variety"] ?? "",
        tradingsymbol: json["tradingsymbol"] ?? "",
        symboltoken: json["symboltoken"] ?? "",
        transactiontype: json["transactiontype"] ?? "",
        exchange: json["exchange"] ?? "",
        ordertype: json["ordertype"] ?? "",
        producttype: json["producttype"] ?? "",
        duration: json["duration"] ?? "",
        price: json["price"] ?? "0.0",
        quantity: json["quantity"] ?? "0",
      );

  Map<String, dynamic> toJson() => {
    "clientcode": clientcode,
    "variety": variety,
    "tradingsymbol": tradingsymbol,
    "symboltoken": symboltoken,
    "transactiontype": transactiontype,
    "exchange": exchange,
    "ordertype": ordertype,
    "producttype": producttype,
    "duration": duration,
    "price": price,
    "quantity": quantity,
  };
}