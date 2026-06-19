class SearchDataByScript {
  int? status;
  String? message;
  String? timestamp;
  List<SearchScript>? data;

  SearchDataByScript({this.status, this.message, this.timestamp, this.data});

  SearchDataByScript.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    timestamp = json['timestamp'];
    if (json['data'] != null) {
      data = <SearchScript>[];
      json['data'].forEach((v) {
        data!.add(new SearchScript.fromJson(v));
      });
    }
  }

}

class SearchScript {
  int? scripCode;
  double? tickSize;
  String? instType;
  int? lotSize;
  String? indices;
  String? expiry;
  double? strike;
  double? multiplier;
  String? optionType;
  String? tradingSymbol;

  SearchScript(
      {this.scripCode,
        this.tickSize,
        this.instType,
        this.lotSize,
        this.indices,
        this.expiry,
        this.strike,
        this.multiplier,
        this.optionType,
        this.tradingSymbol});

  SearchScript.fromJson(Map<String, dynamic> json) {
    scripCode = json['scripCode'];
    tickSize = json['tickSize'];
    instType = json['instType'];
    lotSize = json['lotSize'];
    indices = json['indices'];
    expiry = json['expiry'];
    strike = json['strike'];
    multiplier = json['multiplier'];
    optionType = json['optionType'];
    tradingSymbol = json['tradingSymbol'];
  }

}