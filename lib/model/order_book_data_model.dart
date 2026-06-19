class OrderBookDataModel {
  OrderBookDataModel({
    required this.message,
    required this.results,
  });

  final String message;
  final List<Result> results;

  factory OrderBookDataModel.fromJson(Map<String, dynamic> json){
    return OrderBookDataModel(
      message: json["message"] ?? "",
      results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
    );
  }

}

class Result {
  Result({
    required this.client,
    required this.status,
    required this.data,
  });

  final String client;
  final String status;
  final List<OrderBookData> data;

  factory Result.fromJson(Map<String, dynamic> json){
    return Result(
      client: json["client"] ?? "",
      status: json["status"] ?? "",
      data: json["data"] == null ? [] : List<OrderBookData>.from(json["data"]!.map((x) => OrderBookData.fromJson(x))),
    );
  }

}

class OrderBookData {
  OrderBookData({
    required this.variety,
    required this.ordertype,
    required this.producttype,
    required this.duration,
    required this.price,
    required this.triggerprice,
    required this.quantity,
    required this.disclosedquantity,
    required this.squareoff,
    required this.stoploss,
    required this.trailingstoploss,
    required this.tradingsymbol,
    required this.transactiontype,
    required this.exchange,
    required this.symboltoken,
    required this.ordertag,
    required this.scripconsent,
    required this.instrumenttype,
    required this.strikeprice,
    required this.optiontype,
    required this.expirydate,
    required this.lotsize,
    required this.cancelsize,
    required this.averageprice,
    required this.filledshares,
    required this.unfilledshares,
    required this.orderid,
    required this.text,
    required this.status,
    required this.orderstatus,
    required this.updatetime,
    required this.exchtime,
    required this.exchorderupdatetime,
    required this.fillid,
    required this.filltime,
    required this.parentorderid,
    required this.uniqueorderid,
    required this.exchangeorderid,
    required this.strategycode,
    required this.strategyid,
    required this.clientcode,
    required this.clientName,
  });

   String variety;
  final String ordertype;
  final String producttype;
  final String duration;
  final double price;
  final int triggerprice;
  final String quantity;
  final String disclosedquantity;
  final int squareoff;
  final int stoploss;
  final int trailingstoploss;
  final String tradingsymbol;
  final String transactiontype;
  final String exchange;
  final String symboltoken;
  final String ordertag;
  final dynamic scripconsent;
  final String instrumenttype;
  final int strikeprice;
  final String optiontype;
  final String expirydate;
  final String lotsize;
  final String cancelsize;
  final double averageprice;
  final String filledshares;
  final String unfilledshares;
  final String orderid;
  final String text;
  final String status;
  final String orderstatus;
  final String updatetime;
  final String exchtime;
  final String exchorderupdatetime;
  final String fillid;
  final String filltime;
  final String parentorderid;
  final String uniqueorderid;
  final String exchangeorderid;
  final String strategycode;
  final String strategyid;
   String clientcode;
   String clientName;

  factory OrderBookData.fromJson(Map<String, dynamic> json){
    return OrderBookData(
      variety: json["variety"] ?? "",
      ordertype: json["ordertype"] ?? "",
      producttype: json["producttype"] ?? "",
      duration: json["duration"] ?? "",
      price: json["price"] != null ? (json["price"] as num).toDouble() : 0.0,
      triggerprice: json["triggerprice"] ?? 0,
      quantity: json["quantity"] ?? "",
      disclosedquantity: json["disclosedquantity"] ?? "",
      squareoff: json["squareoff"] ?? 0,
      stoploss: json["stoploss"] ?? 0,
      trailingstoploss: json["trailingstoploss"] ?? 0,
      tradingsymbol: json["tradingsymbol"] ?? "",
      transactiontype: json["transactiontype"] ?? "",
      exchange: json["exchange"] ?? "",
      symboltoken: json["symboltoken"] ?? "",
      ordertag: json["ordertag"] ?? "",
      scripconsent: json["scripconsent"],
      instrumenttype: json["instrumenttype"] ?? "",
      strikeprice: json["strikeprice"] ?? 0,
      optiontype: json["optiontype"] ?? "",
      expirydate: json["expirydate"] ?? "",
      lotsize: json["lotsize"] ?? "",
      cancelsize: json["cancelsize"] ?? "",
      averageprice: json["averageprice"] != null ? (json["averageprice"] as num).toDouble() : 0.0,
      filledshares: json["filledshares"] ?? "",
      unfilledshares: json["unfilledshares"] ?? "",
      orderid: json["orderid"] ?? "",
      text: json["text"] ?? "",
      status: json["status"] ?? "",
      orderstatus: json["orderstatus"] ?? "",
      updatetime: json["updatetime"] ?? "",
      exchtime: json["exchtime"] ?? "",
      exchorderupdatetime: json["exchorderupdatetime"] ?? "",
      fillid: json["fillid"] ?? "",
      filltime: json["filltime"] ?? "",
      parentorderid: json["parentorderid"] ?? "",
      uniqueorderid: json["uniqueorderid"] ?? "",
      exchangeorderid: json["exchangeorderid"] ?? "",
      strategycode: json["strategycode"] ?? "",
      strategyid: json["strategyid"] ?? "",
      clientcode: json["client"] ?? "",
      clientName: json["client"] ?? "",
    );
  }

  // Converts individual OrderBookData objects back into a Map
  Map<String, dynamic> toJson() => {
    "variety": variety,
    "ordertype": ordertype,
    "producttype": producttype,
    "duration": duration,
    "price": price,
    "triggerprice": triggerprice,
    "quantity": quantity,
    "disclosedquantity": disclosedquantity,
    "squareoff": squareoff,
    "stoploss": stoploss,
    "trailingstoploss": trailingstoploss,
    "tradingsymbol": tradingsymbol,
    "transactiontype": transactiontype,
    "exchange": exchange,
    "symboltoken": symboltoken,
    "ordertag": ordertag,
    "scripconsent": scripconsent,
    "instrumenttype": instrumenttype,
    "strikeprice": strikeprice,
    "optiontype": optiontype,
    "expirydate": expirydate,
    "lotsize": lotsize,
    "cancelsize": cancelsize,
    "averageprice": averageprice,
    "filledshares": filledshares,
    "unfilledshares": unfilledshares,
    "orderid": orderid,
    "text": text,
    "status": status,
    "orderstatus": orderstatus,
    "updatetime": updatetime,
    "exchtime": exchtime,
    "exchorderupdatetime": exchorderupdatetime,
    "fillid": fillid,
    "filltime": filltime,
    "parentorderid": parentorderid,
    "uniqueorderid": uniqueorderid,
    "exchangeorderid": exchangeorderid,
    "strategycode": strategycode,
    "strategyid": strategyid,
    "clientcode": clientcode,
    "clientName": clientName,
  };

}

/*
{
	"message": "RMS Batch fetch completed",
	"results": [
		{
			"client": "H54980091",
			"status": "Success",
			"data": [
				{
					"variety": "AMO",
					"ordertype": "LIMIT",
					"producttype": "DELIVERY",
					"duration": "DAY",
					"price": 62,
					"triggerprice": 0,
					"quantity": "1230",
					"disclosedquantity": "0",
					"squareoff": 0,
					"stoploss": 0,
					"trailingstoploss": 0,
					"tradingsymbol": "MOM100-EQ",
					"transactiontype": "BUY",
					"exchange": "NSE",
					"symboltoken": "21423",
					"ordertag": "",
					"scripconsent": null,
					"instrumenttype": "",
					"strikeprice": -1,
					"optiontype": "",
					"expirydate": "",
					"lotsize": "1",
					"cancelsize": "0",
					"averageprice": 0,
					"filledshares": "0",
					"unfilledshares": "1230",
					"orderid": "05127a516671AO",
					"text": "",
					"status": "open",
					"orderstatus": "open",
					"updatetime": "12-May-2026 16:20:25",
					"exchtime": "",
					"exchorderupdatetime": "",
					"fillid": "",
					"filltime": "",
					"parentorderid": "",
					"uniqueorderid": "H54980091_2cc32af5-c6dd-4837-b6e6-0ca9f923c9f7",
					"exchangeorderid": "",
					"strategycode": "N_Spark_Android_126.2.2",
					"strategyid": ""
				}
			]
		}
	]
}*/