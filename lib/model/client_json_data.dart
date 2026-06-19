class ClientJsonDataModel {
  String? ipName;
  String? ipPwd;
  String? port;
  String? clientcode;
  String? password;
  String? totpSecret;
  String? publicIP;
  String? apiKey;
  String? jwtToken;

  ClientJsonDataModel({
    this.ipName,
    this.ipPwd,
    this.port,
    this.clientcode,
    this.password,
    this.totpSecret,
    this.publicIP,
    this.apiKey,
    this.jwtToken,
  });

  factory ClientJsonDataModel.fromJson(Map<String, dynamic> json) {
    return ClientJsonDataModel(
      ipName: json['ipName'],
      ipPwd: json['ipPwd'],
      port: json['port'],
      clientcode: json['clientcode'],
      password: json['password'],
      totpSecret: json['totpSecret'],
      publicIP: json['publicIP'],
      apiKey: json['apiKey'],
      jwtToken: json['jwtToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ipName': ipName,
      'ipPwd': ipPwd,
      'port': port,
      'clientcode': clientcode,
      'password': password,
      'totpSecret': totpSecret,
      'publicIP': publicIP,
      'apiKey': apiKey,
      'jwtToken': jwtToken,
    };
  }
}