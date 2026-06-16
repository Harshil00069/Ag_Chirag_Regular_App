class GetLtpDataModel {
  bool? status;
  String? message;
  String? errorcode;
  Data? data;

  GetLtpDataModel({this.status, this.message, this.errorcode, this.data});

  GetLtpDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errorcode = json['errorcode'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['errorcode'] = this.errorcode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? exchange;
  String? tradingsymbol;
  String? symboltoken;
  String? open;
  String? high;
  String? low;
  String? close;
  String? ltp;

  Data(
      {this.exchange,
        this.tradingsymbol,
        this.symboltoken,
        this.open,
        this.high,
        this.low,
        this.close,
        this.ltp});

  Data.fromJson(Map<String, dynamic> json) {
    exchange = json['exchange'];
    tradingsymbol = json['tradingsymbol'];
    symboltoken = json['symboltoken'];
    open = json['open'];
    high = json['high'];
    low = json['low'];
    close = json['close'];
    ltp = json['ltp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exchange'] = this.exchange;
    data['tradingsymbol'] = this.tradingsymbol;
    data['symboltoken'] = this.symboltoken;
    data['open'] = this.open;
    data['high'] = this.high;
    data['low'] = this.low;
    data['close'] = this.close;
    data['ltp'] = this.ltp;
    return data;
  }
}