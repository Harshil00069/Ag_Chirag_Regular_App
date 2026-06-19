import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer' as developer;

class CommonUtils {
  static List<String> get imagesExtensions => [
    'jpg',
    'jpeg',
    'png',
    'gif',
    'bmp',
    'svg',
  ];

  static List<String> get documentExtensions => [
    'pdf',
    'doc',
    'docx',
    'ppt',
    'pptx',
    'txt',
  ];

  static List<String> get videoExtensions => [
    'mp4',
    'avi',
    'mov',
    'wmv',
    'flv',
    'mkv',
  ];

  static bool isWebLink(String input) {
    return Uri.parse(input).hasAbsolutePath;
  }

  static bool fileIsImageOrNot(String url) {
    String extension = url.split('.').last;
    if (imagesExtensions.contains(extension)) {
      return true;
    }
    return false;
  }

  static bool fileIsVideoOrNot(String url) {
    String extension = url.split('.').last;
    if (videoExtensions.contains(extension)) {
      return true;
    }
    return false;
  }

  static bool fileIsDocumentOrNot(String url) {
    String extension = url.split('.').last;
    if (documentExtensions.contains(extension)) {
      return true;
    }
    return false;
  }


  // static Future<bool> isPermissionGranted() async {
  //   PermissionStatus storagePermissionStatus = await Permission.storage.status;
  //   if (storagePermissionStatus.isGranted) {
  //     return true;
  //   } else if (storagePermissionStatus.isDenied) {
  //     if (await Permission.storage.request().isGranted) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }
  //
  // static Future<bool> requestImagePermission() async {
  //   if (await Permission.photos.request().isGranted ||
  //       await Permission.storage.request().isGranted) {
  //     return true;
  //   }
  //   return false;
  // }
  //
  // static Future<bool> isNotificationPermissionGranted() async {
  //   final status = await Permission.notification.status;
  //
  //   if (status.isGranted) {
  //     return true;
  //   } else {
  //     // For permanently denied or restricted
  //     return false;
  //   }
  // }

  // static Future<bool> requestNotificationPermission() async {
  //   final status = await Permission.notification.status;
  //
  //   if (status.isGranted) {
  //     return true;
  //   } else if (status.isDenied) {
  //     // You can also request here if needed
  //     final result = await Permission.notification.request();
  //     return result.isGranted;
  //   } else {
  //     // For permanently denied or restricted
  //     return false;
  //   }
  // }

  // static Future<void> openFileFromBase64String({
  //   required String base64String,
  //   required String fileName,
  // }) async {
  //   Uint8List bytes = base64.decode(base64String);
  //   String dir = (await getApplicationDocumentsDirectory()).path;
  //
  //   File file = File('$dir/$fileName.pdf');
  //   logMessage(file.path);
  //   File fileNew = await file.writeAsBytes(bytes);
  //   String filePath = fileNew.path;
  //   OpenFilex.open(filePath);
  // }
  //
  // static Future<String> getCurrentIpAddress() async {
  //   return await Ipify.ipv4();
  // }

  // static Future<void> openUrl(
  //   String uri, {
  //   UrlLaunchMode mode = UrlLaunchMode.externalApplication,
  // }) async {
  //   if (uri.isEmpty) return;
  //   var url = Uri.parse(uri);
  //   if (await canLaunchUrl(url)) {
  //     await launchUrl(url, mode: getLaunchMode(mode));
  //   }
  // }
  //
  // static Future<void> launchDialer(String phoneNumber) async {
  //   if (phoneNumber.isEmpty) return;
  //   final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
  //
  //   if (await canLaunchUrl(launchUri)) {
  //     await launchUrl(launchUri);
  //   } else {
  //     throw 'Could not launch $phoneNumber';
  //   }
  // }

  static void logMessage(Object message) {
    if (kDebugMode) {
      developer.log(message.toString());
    }
  }

  static void logErrorMessage(Object message) {
    if (kDebugMode) {
      developer.log('', name: "Error", error: message);
    }
  }

  static String generateCurl(RequestOptions options) {
    try {
      StringBuffer curl = StringBuffer("curl --location '${options.uri}' \\\n");

      // Headers
      options.headers.forEach((k, v) {
        curl.write("--header '$k: $v' \\\n");
      });

      // If content-type is form-urlencoded
      if (options.headers["content-type"] ==
          "application/x-www-form-urlencoded") {
        if (options.data is Map) {
          final map = options.data as Map;
          final encoded = map.entries
              .map(
                (e) =>
                    "${Uri.encodeQueryComponent(e.key)}=${Uri.encodeQueryComponent(e.value.toString())}",
              )
              .join("&");

          curl.write("--data '$encoded' \\\n");
        }

        return curl.toString();
      }

      // FormData
      if (options.data is FormData) {
        FormData form = options.data;

        for (var field in form.fields) {
          curl.write("--form '${field.key}=${field.value}' \\\n");
        }

        for (var file in form.files) {
          curl.write("--form '${file.key}=@\"${file.value.filename}\"' \\\n");
        }

        return curl.toString();
      }

      // Default JSON (fallback)
      if (options.data != null) {
        curl.write("--data '${jsonEncode(options.data)}' \\\n");
      }

      return curl.toString();
    } catch (e) {
      return "Error generating cURL: $e";
    }
  }

/*  static LaunchMode getLaunchMode(UrlLaunchMode mode) {
    switch (mode) {
      case UrlLaunchMode.externalApplication:
        return LaunchMode.externalApplication;
      case UrlLaunchMode.externalNonBrowserApplication:
        return LaunchMode.externalNonBrowserApplication;

      case UrlLaunchMode.inAppBrowser:
        return LaunchMode.inAppBrowserView;
      case UrlLaunchMode.inAppWebView:
        return LaunchMode.inAppWebView;

      default:
        return LaunchMode.platformDefault;
    }
  }

  static Future<File?> cropImage(
    File pickedFile, {
    String? toolbarTitle = 'Crop Image',
    int quality = 80,
    CropAspectRatio? aspectRatio,
    List<CropAspectRatioPresetData> aspectRatioPresets = const [
      CropAspectRatioPreset.square,
    ],
  }) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: quality,
      aspectRatio: aspectRatio,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: toolbarTitle,
          toolbarColor: AppColor.primaryColor,
          toolbarWidgetColor: AppColor.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
          aspectRatioPresets: aspectRatioPresets,
        ),
        IOSUiSettings(
          title: toolbarTitle,
          aspectRatioLockEnabled: true,
          aspectRatioPresets: aspectRatioPresets,
        ),
      ],
    );

    if (croppedFile == null) return null;

    return File(croppedFile.path);
  }

  static Future<File?> compressImage(
    File originalFile, {
    int quality = 80,
  }) async {
    final dir = await getTemporaryDirectory();
    final targetPath = path.join(
      dir.path,
      '${DateTime.now().millisecondsSinceEpoch}.jpg',
    );

    final result = await FlutterImageCompress.compressAndGetFile(
      originalFile.absolute.path,
      targetPath,
      quality: quality, // between 0-100
    );

    return File(result!.path);
  }*/

  // static String formatIndianRupees(double amount) {
  //   var indianRupeeFormat = NumberFormat.currency(
  //     locale: 'en_IN',
  //     symbol: '₹ ',
  //   );
  //   return indianRupeeFormat.format(amount);
  // }

  // static indianRupeesWidget(
  //   double amount, {
  //   String? extension,
  //   Color? amountColor,
  //   Color? extensionColor,
  //   TextStyle? textStyle,
  // }) {
  //   return Text(
  //     '₹ ${roundAmountNumber(formatIndianRupees(amount))}/- ',
  //     style: textStyle ?? TextStyle(),
  //   );
  // }

  static String roundAmountNumber(String amount) {
    String clearAmount = amount.replaceAll(',', '').replaceAll('₹', '').trim();
    return double.parse(clearAmount).round().toString();
  }

  // static Future<bool> requestCameraPermission() async {
  //   var status = await Permission.camera.status;
  //
  //   if (status.isGranted) {
  //     return true;
  //   } else if (status.isDenied || status.isRestricted) {
  //     status = await Permission.camera.request();
  //     return status.isGranted;
  //   } else if (status.isPermanentlyDenied) {
  //     // Open app settings if permission is permanently denied
  //     await openAppSettings();
  //     return false;
  //   }
  //
  //   return false;
  // }

  static String getMonthNameByNumber(int month) {
    switch (month) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Dec";
    }

    return '';
  }
}

enum UrlLaunchMode {
  externalApplication,
  externalNonBrowserApplication,
  externalBrowser,
  inAppBrowser,
  inAppWebView,
}
