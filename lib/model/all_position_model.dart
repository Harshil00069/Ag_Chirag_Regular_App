import 'package:treding/model/user_model.dart';

class AllPositionModel {
  bool? status;
  String? message;
  String? errorcode;
  List<Position>? data;

  AllPositionModel({this.status, this.message, this.errorcode, this.data});

  AllPositionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errorcode = json['errorcode'];
    if (json['data'] != null) {
      data = <Position>[];
      json['data'].forEach((v) {
        data!.add(new Position.fromJson(v));
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

class Position {
  String? exchange;
  String? symboltoken;
  String? producttype;
  String? tradingsymbol;
  String? symbolname;
  String? instrumenttype;
  String? priceden;
  String? pricenum;
  String? genden;
  String? gennum;
  String? precision;
  String? multiplier;
  String? boardlotsize;
  String? buyqty;
  String? sellqty;
  String? buyamount;
  String? sellamount;
  String? symbolgroup;
  String? strikeprice;
  String? optiontype;
  String? expirydate;
  String? lotsize;
  String? cfbuyqty;
  String? cfsellqty;
  String? cfbuyamount;
  String? cfsellamount;
  String? buyavgprice;
  String? sellavgprice;
  String? avgnetprice;
  String? netvalue;
  String? netqty;
  String? totalbuyvalue;
  String? totalsellvalue;
  String? cfbuyavgprice;
  String? cfsellavgprice;
  String? totalbuyavgprice;
  String? totalsellavgprice;
  String? pnl;
  String? ltp;
  String? netprice;
  UserModel? userModel;
  Position(
      {this.exchange,
        this.symboltoken,
        this.producttype,
        this.tradingsymbol,
        this.symbolname,
        this.instrumenttype,
        this.priceden,
        this.pricenum,
        this.genden,
        this.gennum,
        this.precision,
        this.multiplier,
        this.boardlotsize,
        this.buyqty,
        this.sellqty,
        this.buyamount,
        this.sellamount,
        this.symbolgroup,
        this.strikeprice,
        this.optiontype,
        this.expirydate,
        this.lotsize,
        this.cfbuyqty,
        this.cfsellqty,
        this.cfbuyamount,
        this.cfsellamount,
        this.buyavgprice,
        this.sellavgprice,
        this.avgnetprice,
        this.netvalue,
        this.netqty,
        this.totalbuyvalue,
        this.totalsellvalue,
        this.cfbuyavgprice,
        this.cfsellavgprice,
        this.totalbuyavgprice,
        this.totalsellavgprice,
        this.pnl,
        this.ltp,
        this.userModel,
        this.netprice});

  Position.fromJson(Map<String, dynamic> json) {
    exchange = json['exchange'];
    symboltoken = json['symboltoken'];
    producttype = json['producttype'];
    tradingsymbol = json['tradingsymbol'];
    symbolname = json['symbolname'];
    instrumenttype = json['instrumenttype'];
    priceden = json['priceden'];
    pricenum = json['pricenum'];
    genden = json['genden'];
    gennum = json['gennum'];
    precision = json['precision'];
    multiplier = json['multiplier'];
    boardlotsize = json['boardlotsize'];
    buyqty = json['buyqty'];
    sellqty = json['sellqty'];
    buyamount = json['buyamount'];
    sellamount = json['sellamount'];
    symbolgroup = json['symbolgroup'];
    strikeprice = json['strikeprice'];
    optiontype = json['optiontype'];
    expirydate = json['expirydate'];
    lotsize = json['lotsize'];
    cfbuyqty = json['cfbuyqty'];
    cfsellqty = json['cfsellqty'];
    cfbuyamount = json['cfbuyamount'];
    cfsellamount = json['cfsellamount'];
    buyavgprice = json['buyavgprice'];
    sellavgprice = json['sellavgprice'];
    avgnetprice = json['avgnetprice'];
    netvalue = json['netvalue'];
    netqty = json['netqty'];
    totalbuyvalue = json['totalbuyvalue'];
    totalsellvalue = json['totalsellvalue'];
    cfbuyavgprice = json['cfbuyavgprice'];
    cfsellavgprice = json['cfsellavgprice'];
    totalbuyavgprice = json['totalbuyavgprice'];
    totalsellavgprice = json['totalsellavgprice'];
    userModel = json['UserModel'];
    netprice = json['netprice'];
    pnl = json['pnl'];
    ltp = json['ltp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exchange'] = this.exchange;
    data['symboltoken'] = this.symboltoken;
    data['producttype'] = this.producttype;
    data['tradingsymbol'] = this.tradingsymbol;
    data['symbolname'] = this.symbolname;
    data['instrumenttype'] = this.instrumenttype;
    data['priceden'] = this.priceden;
    data['pricenum'] = this.pricenum;
    data['genden'] = this.genden;
    data['gennum'] = this.gennum;
    data['precision'] = this.precision;
    data['multiplier'] = this.multiplier;
    data['boardlotsize'] = this.boardlotsize;
    data['buyqty'] = this.buyqty;
    data['sellqty'] = this.sellqty;
    data['buyamount'] = this.buyamount;
    data['sellamount'] = this.sellamount;
    data['symbolgroup'] = this.symbolgroup;
    data['strikeprice'] = this.strikeprice;
    data['optiontype'] = this.optiontype;
    data['expirydate'] = this.expirydate;
    data['lotsize'] = this.lotsize;
    data['cfbuyqty'] = this.cfbuyqty;
    data['cfsellqty'] = this.cfsellqty;
    data['cfbuyamount'] = this.cfbuyamount;
    data['cfsellamount'] = this.cfsellamount;
    data['buyavgprice'] = this.buyavgprice;
    data['sellavgprice'] = this.sellavgprice;
    data['avgnetprice'] = this.avgnetprice;
    data['netvalue'] = this.netvalue;
    data['netqty'] = this.netqty;
    data['totalbuyvalue'] = this.totalbuyvalue;
    data['totalsellvalue'] = this.totalsellvalue;
    data['cfbuyavgprice'] = this.cfbuyavgprice;
    data['cfsellavgprice'] = this.cfsellavgprice;
    data['totalbuyavgprice'] = this.totalbuyavgprice;
    data['totalsellavgprice'] = this.totalsellavgprice;
    data['netprice'] = this.netprice;
    data['UserModel'] = this.userModel;
    data['pnl'] = this.pnl;
    data['ltp'] = this.ltp;
    return data;
  }
}