class SearchDataModel {
  bool? status;
  String? message;
  String? errorcode;
  List<SearchData>? data;

  SearchDataModel({this.status, this.message, this.errorcode, this.data});

  SearchDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errorcode = json['errorcode'];
    if (json['data'] != null) {
      data = <SearchData>[];
      json['data'].forEach((v) {
        data!.add( SearchData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['errorcode'] = this.errorcode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SearchData {
  // String? exchange;
  // String? tradingsymbol;
  // String? symboltoken;

  String? token;
  String? symbol;
  String? name;
  String? expiry;
  String? strike;
  String? lotsize;
  String? instrumenttype;
  String? exchSeg;
  String? tickSize;

  SearchData({this.token,
    this.symbol,
    this.name,
    this.expiry,
    this.strike,
    this.lotsize,
    this.instrumenttype,
    this.exchSeg,
    this.tickSize});

  SearchData.fromJson(Map<String, dynamic> json) {
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