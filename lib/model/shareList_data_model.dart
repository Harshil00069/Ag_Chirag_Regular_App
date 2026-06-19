class SheetDataModel {
  List<ShareListData>? sheet1;

  SheetDataModel({this.sheet1});

  SheetDataModel.fromJson(Map<String, dynamic> json) {
    if (json['Sheet1'] != null) {
      sheet1 = <ShareListData>[];
      json['Sheet1'].forEach((v) {
        sheet1!.add( ShareListData.fromJson(v));
      });
    }
  }

}

class ShareListData {
  String? Share;
  int? lotSize;

  ShareListData(
      {this.Share,
        this.lotSize,
      });

  ShareListData.fromJson(Map<String, dynamic> json) {
    Share = json['Share'];
    lotSize = json['lotSize'];
  }

}