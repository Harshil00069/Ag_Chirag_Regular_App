class ClientDataModel {
  ClientDataModel({
    required this.message,
    required this.results,
  });

  final String message;
  final List<ClientData> results;

  factory ClientDataModel.fromJson(Map<String, dynamic> json){
    return ClientDataModel(
      message: json["message"] ?? "",
      results: json["results"] == null ? [] : List<ClientData>.from(json["results"]!.map((x) => ClientData.fromJson(x))),
    );
  }

}

class ClientData {
  ClientData({
    required this.client,
    required this.status,
    required this.jwt,
  });

  final String client;
  final String status;
  final String jwt;

  factory ClientData.fromJson(Map<String, dynamic> json){
    return ClientData(
      client: json["client"] ?? "",
      status: json["status"] ?? "",
      jwt: json["jwt"] ?? "",
    );
  }

}

/*
{
	"message": "Batch login completed",
	"results": [
		{
			"client": "AAAA170695",
			"status": "Success",
			"jwt": "eyJhbGciOiJIUzUxMiJ9.eyJ1c2VybmFtZSI6IkFBQUExNzA2OTUiLCJyb2xlcyI6MCwidXNlcnR5cGUiOiJVU0VSIiwidG9rZW4iOiJleUpoYkdjaU9pSlNVekkxTmlJc0luUjVjQ0k2SWtwWFZDSjkuZXlKMWMyVnlYM1I1Y0dVaU9pSmpiR2xsYm5RaUxDSjBiMnRsYmw5MGVYQmxJam9pZEhKaFpHVmZZV05qWlhOelgzUnZhMlZ1SWl3aVoyMWZhV1FpT2pZc0luTnZkWEpqWlNJNklqTWlMQ0prWlhacFkyVmZhV1FpT2lJeU16azRObVJrTmkwM1lqVmxMVE15WWpJdFlqTmxaUzB5TmpSaU1URXlPRE14TVdRaUxDSnJhV1FpT2lKMGNtRmtaVjlyWlhsZmRqSWlMQ0p2Ylc1bGJXRnVZV2RsY21sa0lqbzJMQ0p3Y205a2RXTjBjeUk2ZXlKa1pXMWhkQ0k2ZXlKemRHRjBkWE1pT2lKaFkzUnBkbVVpZlN3aWJXWWlPbnNpYzNSaGRIVnpJam9pWVdOMGFYWmxJbjE5TENKcGMzTWlPaUowY21Ga1pWOXNiMmRwYmw5elpYSjJhV05sSWl3aWMzVmlJam9pUVVGQlFURTNNRFk1TlNJc0ltVjRjQ0k2TVRjM09ESXhOelk0TWl3aWJtSm1Jam94TnpjNE1UTXhNVEF5TENKcFlYUWlPakUzTnpneE16RXhNRElzSW1wMGFTSTZJbVl5WlRkbVpUZGpMVFF5WlRFdE5HVmhOUzFpTWpnekxUWm1NemRqTkdGallqZGpPU0lzSWxSdmEyVnVJam9pSW4wLm5VYkFsekFyblJXOUV3cUFTcGxsalpfajJBV1BKTEYzTFozbGl0SlJZZ2xlYnJVTUdfT2FIanQ5OFhxb01YMWZZQTBXemotbWE3MWRmcTVzdUFLRG5oODF2VkRGMkkxTW5ReWtnUjFMbzRJbVl5VUVVVWlvWlVrNmRCbkpLX3pGT1FfTmZQV1pEZkRRdWVMTFY2M2JObHpzUVhfcFBkZHNWZDdBblV2bFR5VSIsIkFQSS1LRVkiOiJmaUNsVFRsYSIsImlhdCI6MTc3ODEzMTI4MiwiZXhwIjoxNzc4MTc4NjAwfQ.oITD33wW-jJp34XivXiB0lyKo7JfKsyO4N4y-NOdPqUvwSVrzitpxlMITgq5NPf-KU5Z_J4UNBmWH1KCeuwATA"
		},
		{
			"client": "H54980091",
			"status": "Success",
			"jwt": "eyJhbGciOiJIUzUxMiJ9.eyJ1c2VybmFtZSI6Ikg1NDk4MDA5MSIsInJvbGVzIjowLCJ1c2VydHlwZSI6IlVTRVIiLCJ0b2tlbiI6ImV5SmhiR2NpT2lKU1V6STFOaUlzSW5SNWNDSTZJa3BYVkNKOS5leUoxYzJWeVgzUjVjR1VpT2lKamJHbGxiblFpTENKMGIydGxibDkwZVhCbElqb2lkSEpoWkdWZllXTmpaWE56WDNSdmEyVnVJaXdpWjIxZmFXUWlPallzSW5OdmRYSmpaU0k2SWpNaUxDSmtaWFpwWTJWZmFXUWlPaUptWVdJd09XVmpPUzAxTjJVeExUTmxNVEF0T0RNMllpMHlNMkl6TWpFd04yUmtNRGNpTENKcmFXUWlPaUowY21Ga1pWOXJaWGxmZGpJaUxDSnZiVzVsYldGdVlXZGxjbWxrSWpvMkxDSndjbTlrZFdOMGN5STZleUprWlcxaGRDSTZleUp6ZEdGMGRYTWlPaUpoWTNScGRtVWlmU3dpYldZaU9uc2ljM1JoZEhWeklqb2lZV04wYVhabEluMTlMQ0pwYzNNaU9pSjBjbUZrWlY5c2IyZHBibDl6WlhKMmFXTmxJaXdpYzNWaUlqb2lTRFUwT1Rnd01Ea3hJaXdpWlhod0lqb3hOemM0TWpFM05qZzBMQ0p1WW1ZaU9qRTNOemd4TXpFeE1EUXNJbWxoZENJNk1UYzNPREV6TVRFd05Dd2lhblJwSWpvaVlqZG1aR0UzTUdVdFl6ZzJPUzAwTlRRMUxUaGlZall0WVdRMk5UaGxPREkxWTJNMklpd2lWRzlyWlc0aU9pSWlmUS5ZUXdUczB1RXpmdUFxNUNOdTNoa0tuTWs4THBPUXllZW5oRXpvc1pvVnZZd3lsZ1E3eklzSzNzMTRsMUlfSUgtRjJfTjVxRWY1cGNIb1NQZDZlZ19VVlBiTFVscS05a3NpYmROS2Jpa3hJY0xIY3BHQVI5VUZBVURRODZDU2tySC14di0zakxyajVoN1FYa09aRjZ5MUluZ0MxM3VUTUo3QWFiLTJfbnhsSVUiLCJBUEktS0VZIjoiMmZHUEpYRlUiLCJpYXQiOjE3NzgxMzEyODQsImV4cCI6MTc3ODE3ODYwMH0.8rxZys0MkD_BiQ6erLhGdaCfQTxNhJkbBarBZJIkp0ZdHKBk6bac5gZzdBil24gwovyLNmFf9TqF08clV09dRw"
		}
	]
}*/