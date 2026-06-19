class AccountDataModel {
  AccountDataModel({
    required this.message,
    required this.results,
  });

  final String message;
  final List<AccountData> results;

  factory AccountDataModel.fromJson(Map<String, dynamic> json){
    return AccountDataModel(
      message: json["message"] ?? "",
      results: json["results"] == null ? [] : List<AccountData>.from(json["results"]!.map((x) => AccountData.fromJson(x))),
    );
  }

}

class AccountData {
  AccountData({
    required this.client,
    required this.status,
    required this.data,
  });

  final String client;
  final String status;
  final Data? data;

  factory AccountData.fromJson(Map<String, dynamic> json){
    return AccountData(
      client: json["client"] ?? "",
      status: json["status"] ?? "",
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.net,
    required this.availablecash,
    required this.availableintradaypayin,
    required this.availablelimitmargin,
    required this.collateral,
    required this.m2Munrealized,
    required this.m2Mrealized,
    required this.utiliseddebits,
    required this.utilisedspan,
    required this.utilisedoptionpremium,
    required this.utilisedholdingsales,
    required this.utilisedexposure,
    required this.utilisedturnover,
    required this.utilisedpayout,
  });

  final String net;
  final String availablecash;
  final String availableintradaypayin;
  final String availablelimitmargin;
  final String collateral;
  final String m2Munrealized;
  final String m2Mrealized;
  final String utiliseddebits;
  final dynamic utilisedspan;
  final dynamic utilisedoptionpremium;
  final dynamic utilisedholdingsales;
  final dynamic utilisedexposure;
  final dynamic utilisedturnover;
  final String utilisedpayout;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      net: json["net"] ?? "",
      availablecash: json["availablecash"] ?? "",
      availableintradaypayin: json["availableintradaypayin"] ?? "",
      availablelimitmargin: json["availablelimitmargin"] ?? "",
      collateral: json["collateral"] ?? "",
      m2Munrealized: json["m2munrealized"] ?? "",
      m2Mrealized: json["m2mrealized"] ?? "",
      utiliseddebits: json["utiliseddebits"] ?? "",
      utilisedspan: json["utilisedspan"],
      utilisedoptionpremium: json["utilisedoptionpremium"],
      utilisedholdingsales: json["utilisedholdingsales"],
      utilisedexposure: json["utilisedexposure"],
      utilisedturnover: json["utilisedturnover"],
      utilisedpayout: json["utilisedpayout"] ?? "",
    );
  }

}

/*
{
	"message": "RMS Batch fetch completed",
	"results": [
		{
			"client": "AAAA170695",
			"status": "Success",
			"data": {
				"net": "100.2900",
				"availablecash": "100.2900",
				"availableintradaypayin": "0.0000",
				"availablelimitmargin": "0.0000",
				"collateral": "0.0000",
				"m2munrealized": "0.0000",
				"m2mrealized": "0.0000",
				"utiliseddebits": "0.0000",
				"utilisedspan": null,
				"utilisedoptionpremium": null,
				"utilisedholdingsales": null,
				"utilisedexposure": null,
				"utilisedturnover": null,
				"utilisedpayout": "100.2900"
			}
		},
		{
			"client": "H54980091",
			"status": "Success",
			"data": {
				"net": "76309.4300",
				"availablecash": "76309.4300",
				"availableintradaypayin": "0.0000",
				"availablelimitmargin": "0.0000",
				"collateral": "0.0000",
				"m2munrealized": "0.0000",
				"m2mrealized": "0.0000",
				"utiliseddebits": "0.0000",
				"utilisedspan": null,
				"utilisedoptionpremium": null,
				"utilisedholdingsales": null,
				"utilisedexposure": null,
				"utilisedturnover": null,
				"utilisedpayout": "76309.4300"
			}
		}
	]
}*/