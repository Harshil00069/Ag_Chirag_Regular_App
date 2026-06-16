class WatchListModel {
  String? exchange;
  String? tradingsymbol;
  String? symboltoken;
  num? ltp;
  String? lotsize;
  int position = 0;

  WatchListModel(
      {this.exchange, this.tradingsymbol, this.symboltoken,this.position=0,
        this.ltp,
        this.lotsize,
      });

  WatchListModel.fromJson(Map<String, dynamic> json) {
    exchange = json['exchange'];
    tradingsymbol = json['tradingsymbol'];
    symboltoken = json['symboltoken'];
    ltp = json['ltp'];
    lotsize = json['lotsize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exchange'] = this.exchange;
    data['tradingsymbol'] = this.tradingsymbol;
    data['symboltoken'] = this.symboltoken;
    data['ltp'] = this.ltp;
    data['lotsize'] = this.lotsize;
    return data;
  }
}