import 'package:treding/model/user_model.dart';

class AllHoldingsModel {
  bool? status;
  String? message;
  String? errorcode;
  Data? data;

  AllHoldingsModel({this.status, this.message, this.errorcode, this.data});

  AllHoldingsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errorcode = json['errorcode'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
  List<Holdings>? holdings;
  Totalholding? totalholding;

  Data({this.holdings, this.totalholding});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['holdings'] != null) {
      holdings = <Holdings>[];
      json['holdings'].forEach((v) {
        holdings!.add(new Holdings.fromJson(v));
      });
    }
    totalholding = json['totalholding'] != null
        ? new Totalholding.fromJson(json['totalholding'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.holdings != null) {
      data['holdings'] = this.holdings!.map((v) => v.toJson()).toList();
    }
    if (this.totalholding != null) {
      data['totalholding'] = this.totalholding!.toJson();
    }
    return data;
  }
}

class Holdings {
  String? tradingsymbol;
  String? exchange;
  String? isin;
  int? t1quantity;
  int? realisedquantity;
  int? quantity;
  int? authorisedquantity;
  String? product;
  String? privateKey;
  var collateralquantity;
  var collateraltype;
  double? haircut;
  double? averageprice;
  double? ltp;
  String? symboltoken;
  double? close;
  double? profitandloss;
  double? pnlpercentage;
  UserModel? userModel;
  Holdings(
      {this.tradingsymbol,
        this.exchange,
        this.isin,
        this.t1quantity,
        this.realisedquantity,
        this.quantity,
        this.authorisedquantity,
        this.product,
        this.collateralquantity,
        this.collateraltype,
        this.haircut,
        this.averageprice,
        this.ltp,
        this.symboltoken,
        this.close,
        this.profitandloss,
        this.privateKey,
        this.userModel,
        this.pnlpercentage});

  Holdings.fromJson(Map<String, dynamic> json) {
    tradingsymbol = json['tradingsymbol'];
    exchange = json['exchange'];
    isin = json['isin'];
    t1quantity = json['t1quantity'];
    realisedquantity = json['realisedquantity'];
    quantity = json['quantity'];
    authorisedquantity = json['authorisedquantity'];
    product = json['product'];
    collateralquantity = json['collateralquantity'];
    collateraltype = json['collateraltype'];
    haircut = json['haircut'];
    averageprice = json['averageprice'];
    ltp = json['ltp'];
    symboltoken = json['symboltoken'];
    close = json['close'];
    profitandloss = json['profitandloss'];
    pnlpercentage = json['pnlpercentage'];
    userModel = json['UserModel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tradingsymbol'] = this.tradingsymbol;
    data['exchange'] = this.exchange;
    data['isin'] = this.isin;
    data['t1quantity'] = this.t1quantity;
    data['realisedquantity'] = this.realisedquantity;
    data['quantity'] = this.quantity;
    data['authorisedquantity'] = this.authorisedquantity;
    data['product'] = this.product;
    data['collateralquantity'] = this.collateralquantity;
    data['collateraltype'] = this.collateraltype;
    data['haircut'] = this.haircut;
    data['averageprice'] = this.averageprice;
    data['ltp'] = this.ltp;
    data['symboltoken'] = this.symboltoken;
    data['close'] = this.close;
    data['profitandloss'] = this.profitandloss;
    data['pnlpercentage'] = this.pnlpercentage;
    data['UserModel'] = this.userModel;
    return data;
  }
}

class Totalholding {
  int? totalholdingvalue;
  int? totalinvvalue;
  double? totalprofitandloss;
  double? totalpnlpercentage;

  Totalholding(
      {this.totalholdingvalue,
        this.totalinvvalue,
        this.totalprofitandloss,
        this.totalpnlpercentage});

  Totalholding.fromJson(Map<String, dynamic> json) {
    totalholdingvalue = json['totalholdingvalue'];
    totalinvvalue = json['totalinvvalue'];
    totalprofitandloss = json['totalprofitandloss'];
    totalpnlpercentage = json['totalpnlpercentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalholdingvalue'] = this.totalholdingvalue;
    data['totalinvvalue'] = this.totalinvvalue;
    data['totalprofitandloss'] = this.totalprofitandloss;
    data['totalpnlpercentage'] = this.totalpnlpercentage;
    return data;
  }
}