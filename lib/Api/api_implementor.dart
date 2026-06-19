// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:treding/Api/api_urls.dart';
import 'package:treding/Utils/custom_http_exception.dart';
import 'package:treding/model/account_data_model.dart';
import 'package:treding/model/all_holdings_model.dart';
import 'package:treding/model/client_data_model.dart';
import 'package:treding/model/order_book_data_model.dart';
import 'package:treding/model/position_data_model.dart';
import 'package:treding/model/search_data_model.dart';
import 'package:treding/model/search_script_data_model.dart';
import 'package:treding/model/share_price_data_model.dart';

import '../model/CheckVersionInfoModel.dart';
import 'dio_client_base.dart';

class ApiImplementor {
  static Future<Response?> getVersionInfoApiImplementer({
    required String PrivateKey,
    required String clientcode,
    required String password,
    required String totp,
  }) async {
    try {
      return await DioClient.getDioClient()!.post(
          'https://apiconnect.angelone.in/rest/auth/angelbroking/user/v1/loginByPassword',
          options: Options(headers: {
            'content-type': 'application/json',
            // 'Authorization':'Bearer eyJhbGciOiJIUzUxMiJ9.eyJ1c2VybmFtZSI6IkQ4ODMiLCJyb2xlcyI6MCwidXNlcnR5cGUiOiJVU0VSIiwiaWF0IjoxNTk5NzEyNjk4LCJleHAiOjE1OTk3MjE2OTh9.qHZEkOMokMktybarQO3m4NMRVQlF0vvN7rh2lCRkjd2sCYBq3JnOq0yWWOS5Ux_H0pvvt4-ibSmb5HJoKJHOUw',
            'Accept': 'application/json',
            'X-UserType': 'USER',
            'X-SourceID': 'WEB',
            'X-ClientLocalIP': '192.168.168.168',
            'X-ClientPublicIP': '106.193.147.98',
            'X-MACAddress': 'fe80::216e:6507:4b90:3719',
            'X-PrivateKey': '$PrivateKey',
          }),
          data: {
            "clientcode": "$clientcode",
            "password": "$password",
            "totp": "$totp",
            "state": "gujrat",
          });
    } on DioException catch (error) {
      print("Error=> ${error}");
      return error.response;
    }
  }

  static Future<Response?> getUserDetail({
    required String PrivateKey,
    required String authKey,
  }) async {
    try {
      return await DioClient.getDioClient()!.get(
          'https://apiconnect.angelone.in/rest/secure/angelbroking/user/v1/getRMS',
          options: Options(headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $authKey',
            'Accept': 'application/json',
            'X-UserType': 'USER',
            'X-SourceID': 'WEB',
            'X-ClientLocalIP': '192.168.168.168',
            'X-ClientPublicIP': '106.193.147.98',
            'X-MACAddress': 'fe80::216e:6507:4b90:3719',
            'X-PrivateKey': '$PrivateKey',
          }));
    } on DioException catch (error) {
      print("Error=> ${error.message}");
      return error.response;
    }
  }

  static Future<AllHoldingsModel?> getAllHoldingsApi({
    required String PrivateKey,
    required String authKey,
  }) async {
    try {
      final response = await DioClient.getDioClient()!.get(
          'https://apiconnect.angelone.in/rest/secure/angelbroking/portfolio/v1/getAllHolding',
          options: Options(headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $authKey',
            'Accept': 'application/json',
            'X-UserType': 'USER',
            'X-SourceID': 'WEB',
            'X-ClientLocalIP': '192.168.168.168',
            'X-ClientPublicIP': '106.193.147.98',
            'X-MACAddress': 'fe80::216e:6507:4b90:3719',
            'X-PrivateKey': PrivateKey,
          }));
      print(response.realUri);
      if (response.statusCode == 200) {
        print("Data=> ${response.data}");
        print("Data=> ${response.requestOptions.headers}");
        AllHoldingsModel version = AllHoldingsModel.fromJson(response.data);
        return version;
      } else {
        return null;
      }
    } catch (error) {
      print("Error=> ${error}");
      rethrow;
    }
  }

  static Future<CheckVersionInfoModel?> profileApi() async {
    try {
      final response = await DioClient.getDioClient()!.get(
        'https://apiconnect.angelone.in/rest/secure/angelbroking/user/v1/getProfile',
        options: Options(headers: {
          'content-type': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJIUzUxMiJ9.eyJ1c2VybmFtZSI6Ikg1NDk4MDA5MSIsInJvbGVzIjowLCJ1c2VydHlwZSI6IlVTRVIiLCJ0b2tlbiI6ImV5SmhiR2NpT2lKSVV6VXhNaUlzSW5SNWNDSTZJa3BYVkNKOS5leUp6ZFdJaU9pSklOVFE1T0RBd09URWlMQ0psZUhBaU9qRTNNRGsxTmpreU56TXNJbWxoZENJNk1UY3dPVFEzTVRJd05Td2lhblJwSWpvaU56UmlaR1l5TjJJdE9ESTJaUzAwTURVd0xXRm1aall0TVRZelptUXdOakJtT1RBNElpd2liMjF1WlcxaGJtRm5aWEpwWkNJNk1Td2ljMjkxY21ObGFXUWlPaUl6SWl3aWRYTmxjbDkwZVhCbElqb2lZMnhwWlc1MElpd2lkRzlyWlc1ZmRIbHdaU0k2SW5SeVlXUmxYMkZqWTJWemMxOTBiMnRsYmlJc0ltZHRYMmxrSWpveExDSnpiM1Z5WTJVaU9pSXpJaXdpWkdWMmFXTmxYMmxrSWpvaVl6ZzJaV1EwTXpjdE1USXdOeTB6TmpBM0xXSXpPVFF0T1dJNU5UVmxNekppWTJWaElpd2lZV04wSWpwN2ZYMC5KcDlyQTBRdlNOT2Y3RlVyRlhJMmgycmU2a3ZPQlhIWkJ0bVFDZ3QxYkppZl8zV0tqVjFpLThvRkFPbmlQVXU1ZXNER1RBLTlBN3ROeWhhbl83V3dvdyIsIkFQSS1LRVkiOiI5YVlYOVpIMiIsImlhdCI6MTcwOTQ3MTI2NSwiZXhwIjoxNzA5NTY5MjczfQ.h0NTYDwdb2AGpnxO9Y743Xvo19Ei0IR6jYTfde-ztvOyx2z3duRbbZK4fr8uHnBRwE_v2rANLWPoLg6joevU1w',
          'Accept': 'application/json',
          'X-UserType': 'USER',
          'X-SourceID': 'WEB',
          'X-ClientLocalIP': '192.168.168.168',
          'X-ClientPublicIP': '106.193.147.98',
          'X-MACAddress': 'fe80::216e:6507:4b90:3719',
          'X-PrivateKey': '9aYX9ZH2',
        }),
      );
      print(response.realUri);
      if (response.statusCode == 200) {
        print("Data2=> ${response.data}");
        // print("Data=> ${response.requestOptions.headers}");
        CheckVersionInfoModel version =
            CheckVersionInfoModel.fromJson(response.data);
        return version;
      } else {
        return null;
      }
    } catch (error) {
      print("Error=> ${error}");
      rethrow;
    }
  }

  static Future<Response?> getLtpData(
      {required String exchange,
      required String tradingsymbol,
      required String symboltoken,
      required String jwtTkn,
      required String PrivateKey}) async {
    try {
      return await DioClient.getDioClient()!.post(
          'https://apiconnect.angelone.in/rest/secure/angelbroking/order/v1/getLtpData',
          options: Options(headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $jwtTkn',
            'Accept': 'application/json',
            'X-UserType': 'USER',
            'X-SourceID': 'WEB',
            'X-ClientLocalIP': '192.168.168.168',
            'X-ClientPublicIP': '106.193.147.98',
            'X-MACAddress': 'fe80::216e:6507:4b90:3719',
            'X-PrivateKey': '$PrivateKey'
          }),
          data: {
            "exchange": exchange,
            "tradingsymbol": tradingsymbol,
            "symboltoken": symboltoken
          });
    } on DioException catch (error) {
      print("My error $error");
      return error.response;
    }
  }

  static Future<CheckVersionInfoModel?> logout() async {
    try {
      final response = await DioClient.getDioClient()!.post(
          'https://apiconnect.angelone.in/rest/secure/angelbroking/user/v1/logout',
          options: Options(headers: {
            'content-type': 'application/json',
            'Authorization':
                'Bearer eyJhbGciOiJIUzUxMiJ9.eyJ1c2VybmFtZSI6Iks1NzEyNDA3NCIsInJvbGVzIjowLCJ1c2VydHlwZSI6IlVTRVIiLCJ0b2tlbiI6ImV5SmhiR2NpT2lKSVV6VXhNaUlzSW5SNWNDSTZJa3BYVkNKOS5leUp6ZFdJaU9pSkxOVGN4TWpRd056UWlMQ0psZUhBaU9qRTNNVEF3TlRReU9ERXNJbWxoZENJNk1UY3dPVGsxT0RJNE1Td2lhblJwSWpvaU1XRXhOV1l3WVdVdFl6VmtaQzAwT0dGaExUZzNZbVF0WXpZd05EUXlNelExT1RVMElpd2liMjF1WlcxaGJtRm5aWEpwWkNJNk1Td2ljMjkxY21ObGFXUWlPaUl6SWl3aWRYTmxjbDkwZVhCbElqb2lZMnhwWlc1MElpd2lkRzlyWlc1ZmRIbHdaU0k2SW5SeVlXUmxYMkZqWTJWemMxOTBiMnRsYmlJc0ltZHRYMmxrSWpveExDSnpiM1Z5WTJVaU9pSXpJaXdpWkdWMmFXTmxYMmxrSWpvaU9URTJaREUzT0dZdFpUWXhaaTB6TmpnMExXSmtNbVV0WldJeU9XUTROamhrTmpReUlpd2lZV04wSWpwN2ZYMC4zeGNzamdOODhfVVlLR2NPeG9VSWY0Y3k0UEU5dnZXWTlueWY1VG5ZSXVIQlNBRkZnZEYyM2FaM3NVeWpMM29yTFY1NGdVdlBCblNCTE1SelAxTnFBQSIsIkFQSS1LRVkiOiJzRW11MUhXcCIsImlhdCI6MTcwOTk1ODM0MSwiZXhwIjoxNzEwMDU0MjgxfQ.ofA78ReStuG6Md0MEMw_Zs_myFEN3Z1mjz8bv39I0QQjHCmOtb9d1qHYitb6fxEswlHB0iprFw3t9ttAPIny0g',
            'Accept': 'application/json',
            'X-UserType': 'USER',
            'X-SourceID': 'WEB',
            'X-ClientLocalIP': '192.168.168.168',
            'X-ClientPublicIP': '106.193.147.98',
            'X-MACAddress': 'fe80::216e:6507:4b90:3719',
            'X-PrivateKey': 'sEmu1HWp',
          }),
          data: {
            "clientcode": "K57124074",
          });
      print(response.realUri);
      if (response.statusCode == 200) {
        print("Data2=> ${response.data}");
        // print("Data=> ${response.requestOptions.headers}");
        CheckVersionInfoModel version =
            CheckVersionInfoModel.fromJson(response.data);
        return version;
      } else {
        return null;
      }
    } catch (error) {
      print("Error=> ${error}");
      rethrow;
    }
  }

  static Future<Response?> getAllShareData() async {
    try {
      return await DioClient.getDioClient()!.get(ApiUrls.GetAllSharesData);
    } on DioException catch (e) {
      return e.response;
    }
  }

  static Future<Response?> placeOrderApiImplementer({
    required String PrivateKey,
    required Map data,
    required String token,
  }) async {
    try {
      return await DioClient.getDioClient()!.post(
          'https://apiconnect.angelone.in/rest/secure/angelbroking/order/v1/placeOrder',
          options: Options(headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            'X-UserType': 'USER',
            'X-SourceID': 'WEB',
            'X-ClientLocalIP': '192.168.168.168',
            'X-ClientPublicIP': '106.193.147.98',
            'X-MACAddress': 'fe80::216e:6507:4b90:3719',
            'X-PrivateKey': '$PrivateKey',
          }),
          data: data);
    } on DioException catch (error) {
      print("Error=> ${error}");
      return error.response;
    }
  }

  static Future<Response?> getOrderListApiImplementer({
    required String PrivateKey,
    required String token,
  }) async {
    try {
      var myData = {
        'content-type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'X-UserType': 'USER',
        'X-SourceID': 'WEB',
        'X-ClientLocalIP': '192.168.168.168',
        'X-ClientPublicIP': '106.193.147.98',
        'X-MACAddress': 'fe80::216e:6507:4b90:3719',
        'X-PrivateKey': '$PrivateKey',
      };
      print(myData);
      return await DioClient.getDioClient()!.get(
          'https://apiconnect.angelone.in/rest/secure/angelbroking/order/v1/getOrderBook',
          options: Options(headers: myData),
          data: "");
    } on DioException catch (error) {
      print("Error=> ${error.message}");
      return error.response;
    }
  }

  static Future<Response?> getPositionListApiImplementer({
    required String PrivateKey,
    required String token,
  }) async {
    try {
      var myData = {
        'content-type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'X-UserType': 'USER',
        'X-SourceID': 'WEB',
        'X-ClientLocalIP': '192.168.168.168',
        'X-ClientPublicIP': '106.193.147.98',
        'X-MACAddress': 'fe80::216e:6507:4b90:3719',
        'X-PrivateKey': '$PrivateKey',
      };
      print(myData);
      return await DioClient.getDioClient()!.get(
          'https://apiconnect.angelone.in/rest/secure/angelbroking/order/v1/getPosition',
          options: Options(headers: myData),
          data: "");
    } on DioException catch (error) {
      print("Error=> ${error.message}");
      return error.response;
    }
  }

  static Future<Response?> singleOrderUpdateApiImplementer({
    required String PrivateKey,
    required Map data,
    required String token,
  }) async {
    try {
      return await DioClient.getDioClient()!.post(
          'https://apiconnect.angelone.in/rest/secure/angelbroking/order/v1/modifyOrder',
          options: Options(headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            'X-UserType': 'USER',
            'X-SourceID': 'WEB',
            'X-ClientLocalIP': '192.168.168.168',
            'X-ClientPublicIP': '106.193.147.98',
            'X-MACAddress': 'fe80::216e:6507:4b90:3719',
            'X-PrivateKey': '$PrivateKey',
          }),
          data: data);
    } on DioException catch (error) {
      print("Error=> ${error}");
      return error.response;
    }
  }

  static Future<Response?> cancleOrderApiImplementer({
    required String PrivateKey,
    required String token,
    required String variety,
    required String orderid,
  }) async {
    try {
      return await DioClient.getDioClient()!.post(
          'https://apiconnect.angelone.in/rest/secure/angelbroking/order/v1/cancelOrder',
          options: Options(headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            'X-UserType': 'USER',
            'X-SourceID': 'WEB',
            'X-ClientLocalIP': '192.168.168.168',
            'X-ClientPublicIP': '106.193.147.98',
            'X-MACAddress': 'fe80::216e:6507:4b90:3719',
            'X-PrivateKey': '$PrivateKey',
          }),
          data: {
            "variety": variety,
            "orderid": orderid,
          });
    } on DioException catch (error) {
      print("Error=> ${error}");
      return error.response;
    }
  }

  //----------------------------- new Code ------------------------------------------------------------------


  static Future<SearchScriptDataModel> loadScriptApiImplementer() async {
    try {
      final response = await DioClient.clientGet("Search_Script", body: {},
      );
      if (response.statusCode == 200) {
        return SearchScriptDataModel.fromJson(response.data);
      } else {
        throw CustomHttpException(
          exceptionMsg: response.statusMessage.toString(),
        );
      }
    } catch (error) {
      logData(error);
      rethrow;
    }
  }

  static Future<SearchDataModel> searchScriptApiImplementer({required String type}) async {
    try {
      final response = await DioClient.clientGet("GetSegmentData/$type", body: {},
      );
      if (response.statusCode == 200) {
        return SearchDataModel.fromJson(response.data);
      } else {
        throw CustomHttpException(
          exceptionMsg: response.statusMessage.toString(),
        );
      }
    } catch (error) {
      logData(error);
      rethrow;
    }
  }


  static Future<ClientDataModel> userLoginApiImplementer({required List userList}) async {
    try {
      final response = await DioClient.clientPost("loginUser",
        body: {
          'userList': jsonEncode(userList),
        },
      );
      if (response.statusCode == 200) {
        return ClientDataModel.fromJson(response.data);
      } else {
        throw CustomHttpException(
          exceptionMsg: response.statusMessage.toString(),
        );
      }
    } catch (error) {
      logData(error);
      rethrow;
    }
  }


  static Future<AccountDataModel> userAccountDetailApiImplementer({required List userList}) async {
    try {
      final response = await DioClient.clientPost("getRMS",
        body: {
          'userList': jsonEncode(userList),
        },
      );
      if (response.statusCode == 200) {
        return AccountDataModel.fromJson(response.data);
      } else {
        throw CustomHttpException(
          exceptionMsg: response.statusMessage.toString(),
        );
      }
    } catch (error) {
      logData(error);
      rethrow;
    }
  }


  static Future<SharePriceDataModel> getLtpApiImplementer({required List userList, required List ltpList}) async {
    try {
      final response = await DioClient.clientPost("getLTP",
        body: {
          'userList': jsonEncode(userList),
          'ltpList': jsonEncode(ltpList),
        },
      );;
      if (response.statusCode == 200) {
        return SharePriceDataModel.fromJson(response.data);
      } else {
        throw CustomHttpException(
          exceptionMsg: response.statusMessage.toString(),
        );
      }
    } catch (error) {
      logData(error);
      rethrow;
    }
  }


  static Future<OrderBookDataModel> getOrdersListApiImplementer({required List userList}) async {
    try {
      final response = await DioClient.clientPost("getOrderBook",
        body: {
          'userList': jsonEncode(userList),
        },
      );
      if (response.statusCode == 200) {
        return OrderBookDataModel.fromJson(response.data);
      } else {
        throw CustomHttpException(
          exceptionMsg: response.statusMessage.toString(),
        );
      }
    } catch (error) {
      logData(error);
      rethrow;
    }
  }

  static Future<SharePriceDataModel> cancelOrdersApiImplementer({required List userList, required List cancelOrderList}) async {
    try {
      final response = await DioClient.clientPost("getOrderCancel",
        body: {
          'userList': jsonEncode(userList),
          'cancelOrderList': jsonEncode(cancelOrderList),
        },
      );;
      if (response.statusCode == 200) {
        return SharePriceDataModel.fromJson(response.data);
      } else {
        throw CustomHttpException(
          exceptionMsg: response.statusMessage.toString(),
        );
      }
    } catch (error) {
      logData(error);
      rethrow;
    }
  }


  static Future<PositionDataModel> getPositionApiImplementer({required List userList}) async {
    try {
      final response = await DioClient.clientPost("getPositionData",
        body: {
          'userList': jsonEncode(userList),
        },
      );
      // logData(response.realUri);
      // logData(response.data);
      if (response.statusCode == 200) {
        return PositionDataModel.fromJson(response.data);
      } else {
        throw CustomHttpException(
          exceptionMsg: response.statusMessage.toString(),
        );
      }
    } catch (error) {
      logData(error);
      rethrow;
    }
  }

  static Future<SharePriceDataModel> getOrderPlaceApiImplementer({required List userList, required List orderList}) async {
    try {
      final response = await DioClient.clientPost("getOrderPlace",
        body: {
          'userList': jsonEncode(userList),
          'placeOrderList': jsonEncode(orderList),
        },
      );;
      if (response.statusCode == 200) {
        return SharePriceDataModel.fromJson(response.data);
      } else {
        throw CustomHttpException(
          exceptionMsg: response.statusMessage.toString(),
        );
      }
    } catch (error) {
      logData(error);
      rethrow;
    }
  }


  static Future<SharePriceDataModel> getModifyOrderPlaceApiImplementer({required List userList, required List orderList}) async {
    try {
      final response = await DioClient.clientPost("getOrderModify",
        body: {
          'userList': jsonEncode(userList),
          'modifyOrderList': jsonEncode(orderList),
        },
      );;
      if (response.statusCode == 200) {
        return SharePriceDataModel.fromJson(response.data);
      } else {
        throw CustomHttpException(
          exceptionMsg: response.statusMessage.toString(),
        );
      }
    } catch (error) {
      logData(error);
      rethrow;
    }
  }


  /// Log debug Data
  static void logData(Object? object) {
    if (kDebugMode) {
      print(object);
    }
  }

}
