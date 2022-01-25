import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:song_tea_app/helper/st_color.dart';

enum STFontSize {
  verySmall,
  small,
  smaller,
  medium,
  large,
  extraLarge,

  /// for AppBar
  verySmallPx,
  smallPx,
  mediumPx,
  largePx,
  extraLargePx,
}

enum STFontFamily { poppin, monsterrat, quicksan }

class STFont {
  STFont();

  static String getTextStyle(STFontFamily font) {
    switch (font) {
      case STFontFamily.poppin:
        return 'Poppins';
      case STFontFamily.monsterrat:
        return 'Monsterrat';
      case STFontFamily.quicksan:
        return 'Quicksand';
      default:
        return 'Source Sans Pro';
    }
  }
}

class STSize {
  STSize();

  static double getDouble(STFontSize size) {
    switch (size) {
      case STFontSize.medium:
        return 18; //font 50

      case STFontSize.large:
        return 23; //font 60

      case STFontSize.extraLarge:
        return 25; //font 80

      case STFontSize.smaller:
        return 12; //font 40

      case STFontSize.small:
        return 14; //font 40

      case STFontSize.verySmall:
        return 11; //font 30

      /// for AppBar
      case STFontSize.mediumPx:
        return 16.5; //font 50

      case STFontSize.largePx:
        return 19.8; //font 60

      case STFontSize.extraLargePx:
        return 26.4; //font 80

      case STFontSize.smallPx:
        return 13.2; //font 40

      case STFontSize.verySmallPx:
        return 9.9; //font 30

      default: //RCFontSize.verySmall:
        return 0.027; //font 30
    }
  }
}

class STText extends StatelessWidget {
  final String text;
  final TextOverflow textOverflow;
  final TextAlign align;
  final STColor stColor;
  final Color color;
  final STFontFamily fontFamily;
  final STFontSize fontSize;
  final String semaStringabel;
  final int maxLines;
  final TextDecoration decoration;
  final FontWeight fontWeight;
  const STText(
      {Key? key,
      required this.text,
      this.textOverflow = TextOverflow.fade,
      this.align = TextAlign.start,
      this.semaStringabel = '',
      this.maxLines = 1,
      this.stColor = STColor.black,
      this.color = Colors.black,
      this.fontFamily = STFontFamily.quicksan,
      this.fontSize = STFontSize.small,
      this.decoration = TextDecoration.none,
      this.fontWeight = FontWeight.normal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: textOverflow,
      style: getTextStyle(
        fontFamily: fontFamily,
        stColor: stColor,
        color: color,
        fontSize: fontSize,
        decoration: decoration,
        fontWeight: fontWeight,
      ),
      semanticsLabel: semaStringabel,
      maxLines: maxLines,
      textAlign: align,
      softWrap: true,
    );
  }

  static TextStyle getTextStyle(
      {STFontFamily fontFamily = STFontFamily.quicksan,
      STColor stColor = STColor.black,
      Color color = Colors.black,
      STFontSize fontSize = STFontSize.medium,
      TextDecoration decoration = TextDecoration.none,
      FontWeight fontWeight = FontWeight.normal}) {
    double size = STSize.getDouble(fontSize);
    return TextStyle(
      fontWeight: fontWeight,
      fontFamily: STFont.getTextStyle(fontFamily),
      fontSize: size,
      color:
          stColor == STColor.none ? color : ClsSTColor.getColor(color: stColor),
      decoration: decoration,
    );
  }
}
