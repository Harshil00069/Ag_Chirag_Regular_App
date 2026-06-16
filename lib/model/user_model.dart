class UserModel {
  String? privateKey;
  String? clientcode;
  String? password;
  String? secretKey;
  String? username;
  String? jwtToken;
  String? PNL;
  String? positionPNL;
  String? currentBalance;
  bool? isUserEnable;
  bool  ischecked = false;
  String? userLotSize;
  UserModel(
      {this.privateKey,
        this.clientcode,
        this.password,
        this.secretKey,
        this.username,
        this.jwtToken,
        this.PNL,
        this.positionPNL,
        this.currentBalance,
        this.userLotSize,
        this.isUserEnable,
        this.ischecked = false,
      });

  UserModel.fromJson(Map<String, dynamic> json) {
    privateKey = json['PrivateKey'];
    clientcode = json['clientcode'];
    password = json['password'];
    secretKey = json['secretKey'];
    username = json['username'];
    jwtToken = json['jwtToken'];
    PNL = json['PNL'];
    currentBalance = json['currentBalance'];
    userLotSize = json['lotsize'];
    isUserEnable = json['isUserEnable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['PrivateKey'] = this.privateKey;
    data['clientcode'] = this.clientcode;
    data['password'] = this.password;
    data['secretKey'] = this.secretKey;
    data['username'] = this.username;
    data['jwtToken'] = this.jwtToken;
    data['PNL'] = this.PNL;
    data['currentBalance'] = this.currentBalance;
    data['lotsize'] = this.userLotSize;
    data['isUserEnable'] = this.isUserEnable;
    return data;
  }
}