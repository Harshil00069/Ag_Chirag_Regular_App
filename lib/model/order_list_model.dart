

import 'package:treding/model/user_model.dart';

class OrderListModel {
  String? variety;
  String? ordertype;
  String? producttype;
  String? duration;
  num? price;
  num? triggerprice;
  String? quantity;
  String? disclosedquantity;
  double? squareoff;
  double? stoploss;
  double? trailingstoploss;
  String? tradingsymbol;
  String? transactiontype;
  String? exchange;
  String? symboltoken;
  String? ordertag;
  String? instrumenttype;
  double? strikeprice;
  String? optiontype;
  String? expirydate;
  String? lotsize;
  String? cancelsize;
  double? averageprice;
  String? filledshares;
  String? unfilledshares;
  String? orderid;
  String? text;
  String? status;
  String? orderstatus;
  String? updatetime;
  String? exchtime;
  String? exchorderupdatetime;
  String? fillid;
  String? filltime;
  String? parentorderid;
  String? uniqueorderid;
  UserModel? userModel;
  int unicID =0;

  OrderListModel(
      {this.variety,
        this.ordertype,
        this.producttype,
        this.duration,
        this.price,
        this.triggerprice,
        this.quantity,
        this.disclosedquantity,
        this.squareoff,
        this.stoploss,
        this.trailingstoploss,
        this.tradingsymbol,
        this.transactiontype,
        this.exchange,
        this.symboltoken,
        this.ordertag,
        this.instrumenttype,
        this.strikeprice,
        this.optiontype,
        this.expirydate,
        this.lotsize,
        this.cancelsize,
        this.averageprice,
        this.filledshares,
        this.unfilledshares,
        this.orderid,
        this.text,
        this.status,
        this.orderstatus,
        this.updatetime,
        this.exchtime,
        this.exchorderupdatetime,
        this.fillid,
        this.filltime,
        this.parentorderid,
        this.uniqueorderid,
        this.userModel,
        required this.unicID,
      });

  OrderListModel.fromJson(Map<String, dynamic> json) {
    variety = json['variety'];
    ordertype = json['ordertype'];
    producttype = json['producttype'];
    duration = json['duration'];
    price = json['price'];
    triggerprice = json['triggerprice'];
    quantity = json['quantity'];
    disclosedquantity = json['disclosedquantity'];
    squareoff = json['squareoff'];
    stoploss = json['stoploss'];
    trailingstoploss = json['trailingstoploss'];
    tradingsymbol = json['tradingsymbol'];
    transactiontype = json['transactiontype'];
    exchange = json['exchange'];
    symboltoken = json['symboltoken'];
    ordertag = json['ordertag'];
    instrumenttype = json['instrumenttype'];
    strikeprice = json['strikeprice'];
    optiontype = json['optiontype'];
    expirydate = json['expirydate'];
    lotsize = json['lotsize'];
    cancelsize = json['cancelsize'];
    averageprice = json['averageprice'];
    filledshares = json['filledshares'];
    unfilledshares = json['unfilledshares'];
    orderid = json['orderid'];
    text = json['text'];
    status = json['status'];
    orderstatus = json['orderstatus'];
    updatetime = json['updatetime'];
    exchtime = json['exchtime'];
    exchorderupdatetime = json['exchorderupdatetime'];
    fillid = json['fillid'];
    filltime = json['filltime'];
    parentorderid = json['parentorderid'];
    userModel = json['UserModel'];
    unicID = 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variety'] = this.variety;
    data['ordertype'] = this.ordertype;
    data['producttype'] = this.producttype;
    data['duration'] = this.duration;
    data['price'] = this.price;
    data['triggerprice'] = this.triggerprice;
    data['quantity'] = this.quantity;
    data['disclosedquantity'] = this.disclosedquantity;
    data['squareoff'] = this.squareoff;
    data['stoploss'] = this.stoploss;
    data['trailingstoploss'] = this.trailingstoploss;
    data['tradingsymbol'] = this.tradingsymbol;
    data['transactiontype'] = this.transactiontype;
    data['exchange'] = this.exchange;
    data['symboltoken'] = this.symboltoken;
    data['ordertag'] = this.ordertag;
    data['instrumenttype'] = this.instrumenttype;
    data['strikeprice'] = this.strikeprice;
    data['optiontype'] = this.optiontype;
    data['expirydate'] = this.expirydate;
    data['lotsize'] = this.lotsize;
    data['cancelsize'] = this.cancelsize;
    data['averageprice'] = this.averageprice;
    data['filledshares'] = this.filledshares;
    data['unfilledshares'] = this.unfilledshares;
    data['orderid'] = this.orderid;
    data['text'] = this.text;
    data['status'] = this.status;
    data['orderstatus'] = this.orderstatus;
    data['updatetime'] = this.updatetime;
    data['exchtime'] = this.exchtime;
    data['exchorderupdatetime'] = this.exchorderupdatetime;
    data['fillid'] = this.fillid;
    data['filltime'] = this.filltime;
    data['parentorderid'] = this.parentorderid;
    data['uniqueorderid'] = this.uniqueorderid;
    data['UserModel'] = this.userModel;
    return data;
  }
}