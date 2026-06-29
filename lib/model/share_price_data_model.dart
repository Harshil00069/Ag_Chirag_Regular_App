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
    required this.ltp,
  });

  final String exchange;
  final String tradingsymbol;
  final String symboltoken;
  final double ltp;

  factory SharePriceData.fromJson(Map<String, dynamic> json){
    return SharePriceData(
      exchange: json["exchange"] ?? "",
      tradingsymbol: json["tradingsymbol"] ?? "",
      symboltoken: json["symboltoken"] ?? "",
      ltp: (json["ltp"] as num?)?.toDouble() ?? 0.0,
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