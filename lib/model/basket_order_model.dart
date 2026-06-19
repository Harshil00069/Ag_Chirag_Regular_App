class BasketListModel {

  String? tradingsymbol;
  String? lotsize;
  String? price;
  String? oderType;


  BasketListModel(
      { this.tradingsymbol,
        this.lotsize,
        this.oderType,
        this.price,
      });

  BasketListModel.fromJson(Map<String, dynamic> json) {
    tradingsymbol = json['tradingsymbol'];
  }


}


class BasketOrderListModel {

  String? tradingsymbol;
  String? symboltoken;
  String? totalQty;
  String? price;
  String? oderType;
  String? username;
  String? exchange;
  String? variety;
  String? ordertype;
  String? producttype;
  String? privateKey;
  String? jwtToken;
  String? clientCode;

  BasketOrderListModel(
      { this.tradingsymbol,
        this.totalQty,
        this.symboltoken,
        this.oderType,
        this.price,
        this.username,
        this.exchange,
        this.variety,
        this.ordertype,
        this.producttype,
        this.jwtToken,
        this.privateKey,
        this.clientCode,
      });

  BasketOrderListModel.fromJson(Map<String, dynamic> json) {
    tradingsymbol = json['tradingsymbol'];
  }


}