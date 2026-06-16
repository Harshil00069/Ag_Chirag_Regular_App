// class CheckVersionInfoModel {
//   bool? status;
//   String? message;
//   String? errorcode;
//   List<Data>? data;
//
//   CheckVersionInfoModel({this.status, this.message, this.errorcode, this.data});
//
//   CheckVersionInfoModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     errorcode = json['errorcode'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(Data.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     data['errorcode'] = this.errorcode;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Data {
//   String? exchange;
//   String? tradingsymbOl;
//   String? symboltoken;
//   String? tradingsymbol;
//
//   Data(
//       {this.exchange,
//         this.tradingsymbOl,
//         this.symboltoken,
//         this.tradingsymbol});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     exchange = json['exchange'];
//     tradingsymbOl = json['tradingsymb{ol'];
//     symboltoken = json['symboltoken'];
//     tradingsymbol = json['tradingsymbol'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['exchange'] = this.exchange;
//     data['tradingsymb{ol'] = this.tradingsymbOl;
//     data['symboltoken'] = this.symboltoken;
//     data['tradingsymbol'] = this.tradingsymbol;
//     return data;
//   }
// }

class CheckVersionInfoModel {
  String? exchange;
  String? tradingsymbOl;
  String? symboltoken;
  num? ltp;
  num? lotsize;

  CheckVersionInfoModel(
      {this.exchange,
        this.tradingsymbOl,
        this.symboltoken,
        this.ltp,
        this.lotsize
      });

  CheckVersionInfoModel.fromJson(Map<String, dynamic> json) {
    exchange = json['exchange'];
    tradingsymbOl = json['tradingsymbol'];
    symboltoken = json['symboltoken'];
    ltp = json['ltp'];
    lotsize = json['lotsize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exchange'] = this.exchange;
    data['tradingsymbol'] = this.tradingsymbOl;
    data['symboltoken'] = this.symboltoken;
    data['ltp'] = this.ltp;
    data['lotsize'] = this.lotsize;
    return data;
  }
}
