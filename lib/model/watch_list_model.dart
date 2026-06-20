class WatchListModel {
  String? exchange;
  String? tradingsymbol;
  String? symboltoken;
  double ltp =0.0;
  String? lotsize;
  int position = 0;

  WatchListModel({
    this.exchange,
    this.tradingsymbol,
    this.symboltoken,
    this.position = 0,
    this.ltp=0.0,
    this.lotsize,
  });

  WatchListModel.fromJson(Map<String, dynamic> json) {
    exchange = json['exchange'];
    tradingsymbol = json['tradingsymbol'];
    symboltoken = json['symboltoken'];
    // Safely handles both integers and doubles from the API response
    ltp =(json['ltp'] as num?)?.toDouble() ?? 0.0;

    lotsize = json['lotsize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exchange'] = this.exchange;
    data['tradingsymbol'] = this.tradingsymbol;
    data['symboltoken'] = this.symboltoken;
    data['ltp'] = this.ltp ?? 0.0;
    data['lotsize'] = this.lotsize;
    return data;
  }
}