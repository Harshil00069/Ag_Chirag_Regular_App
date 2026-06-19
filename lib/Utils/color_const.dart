import 'dart:ui';

class ColorConst {
  static Color colorPrimary = HexColor("#6D336D");
  static Color colorAccent = HexColor("#FFFFFF");
  static Color colorDateSel = HexColor("#FFC73C");
  static Color header1 = HexColor("#B8D4FF");
  static Color header2 = HexColor("#E8F1FF");
  static Color greyColor = HexColor("#666666");
  static Color headerColor = HexColor("#293594");
  static Color blackColor = HexColor("#000000");

  // static Color headerColor = HexColor("#2D3FA8");
  static Color mapHeaderColor = HexColor("#293594");
  static Color mapTxtColor = HexColor("#777FB9");
  static Color btnColor = HexColor("#B8D4FF");
  static Color routeBgColor = HexColor("#EAF1FF");
  static Color txtBgColor = HexColor("#F4F6FF");
  static Color otpBgColor = HexColor("#E5E5FF");
  static Color bookedColor = HexColor("#BDBDBD");
  static Color selectedColor = HexColor("#B2BBFF");
  static Color femaleColor = HexColor("#FFADDE");
  
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
