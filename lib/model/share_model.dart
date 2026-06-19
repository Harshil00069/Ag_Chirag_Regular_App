class ShareModel {
  String? token;
  String? symbol;
  String? name;
  String? expiry;
  String? strike;
  String? lotsize;
  String? instrumenttype;
  String? exchSeg;
  String? tickSize;

  ShareModel(
      {this.token,
        this.symbol,
        this.name,
        this.expiry,
        this.strike,
        this.lotsize,
        this.instrumenttype,
        this.exchSeg,
        this.tickSize});

  ShareModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    symbol = json['symbol'];
    name = json['name'];
    expiry = json['expiry'];
    strike = json['strike'];
    lotsize = json['lotsize'];
    instrumenttype = json['instrumenttype'];
    exchSeg = json['exch_seg'];
    tickSize = json['tick_size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['symbol'] = this.symbol;
    data['name'] = this.name;
    data['expiry'] = this.expiry;
    data['strike'] = this.strike;
    data['lotsize'] = this.lotsize;
    data['instrumenttype'] = this.instrumenttype;
    data['exch_seg'] = this.exchSeg;
    data['tick_size'] = this.tickSize;
    return data;
  }
}
