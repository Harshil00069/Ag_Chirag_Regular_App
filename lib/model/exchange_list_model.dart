class ExchangeModel {
  List<ExchangeListData>? exchangeDataList;

  ExchangeModel({this.exchangeDataList});

  ExchangeModel.fromJson(Map<String, dynamic> json) {
    if (json['Sheet1'] != null) {
      exchangeDataList = <ExchangeListData>[];
      json['Sheet1'].forEach((v) {
        exchangeDataList!.add( ExchangeListData.fromJson(v));
      });
    }
  }

}

class ExchangeListData {
 late String exchangeName;
 late String shortName;

  ExchangeListData(
      {this.exchangeName ="",
        this.shortName ="",
      });

  ExchangeListData.fromJson(Map<String, dynamic> json) {
    exchangeName = json['exchangeName'] ??"";
    shortName = json['shortName'] ??"";
  }

}