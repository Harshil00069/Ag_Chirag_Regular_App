class SharePriceDataModel {
  SharePriceDataModel({
    required this.status,
    required this.count,
    required this.results,
  });

  final String status;
  final int count;
  final List<SharePriceData> results;

  factory SharePriceDataModel.fromJson(Map<String, dynamic> json){
    return SharePriceDataModel(
      status: json["status"] ?? "",
      count: json["count"] ?? 0,
      results: json["results"] == null ? [] : List<SharePriceData>.from(json["results"]!.map((x) => SharePriceData.fromJson(x))),
    );
  }

}

class SharePriceData {
  SharePriceData({
    required this.exchange,
    required this.tradingsymbol,
    required this.symboltoken,
    // required this.open,
    // required this.high,
    // required this.low,
    // required this.close,
    required this.ltp,
  });

  final String exchange;
  final String tradingsymbol;
  final String symboltoken;
  // final double open;
  // final double high;
  // final double low;
  // final double close;
  final double ltp;

  factory SharePriceData.fromJson(Map<String, dynamic> json){
    return SharePriceData(
      exchange: json["exchange"] ?? "",
      tradingsymbol: json["tradingsymbol"] ?? "",
      symboltoken: json["symboltoken"] ?? "",
      // open: json["open"] ?? 0.0,
      // high: json["high"] ?? 0.0,
      // low: json["low"] ?? 0.0,
      // close: json["close"] ?? 0.0,
      ltp: json["ltp"] ?? 0.0,
    );
  }

}

/*
{
	"status": "Completed",
	"count": 2,
	"results": [
		{
			"exchange": "NSE",
			"tradingsymbol": "MOM100-EQ",
			"symboltoken": "21423",
			"open": 66.5,
			"high": 66.5,
			"low": 64.08,
			"close": 65.9,
			"ltp": 64.17
		},
		{
			"exchange": "NSE",
			"tradingsymbol": "MOM100-EQ",
			"symboltoken": "21423",
			"open": 66.5,
			"high": 66.5,
			"low": 64.08,
			"close": 65.9,
			"ltp": 64.17
		}
	]
}*/