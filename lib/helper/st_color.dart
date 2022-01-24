import 'dart:ui';

import 'package:flutter/material.dart';

enum STColor {
  transparent,
  black,
  black60,
  white,
  green,
  lightGreen,
  green60,
  lightGrey,
  grey,
  red,
  red60,
  blueButton,
  blueAccent,
  stawberry,
  yellow,
  background,
  greyBackground,
  placeHolder,
  buttonColor,
  darkOrange,
  blurDarkOrange,
  type,

  statusComplete,
  statusInProgress,

  none,

  statusPending,
  statusPendingMap,
  statusRepairing,
  statusRepairingMap,
  statusFixed,
  statusFixedMap,
  statusInPlanning,
  statusSpecialist,
  statusDeclined,
  statusInvalid,

  notificationPending,
  notificationRepairing,
  notificationFixed,
  notificationInPlanning,
  notificationDeclined,
  notificationComment,
  notificationReward,

  mainColor,
  appBarColor
}

class ClsSTColor {
  ClsSTColor();

  static STColor getSTColorByName(
      {String colorName = '', String colorPrefix = 'status'}) {
    for (var i = 0; i < STColor.values.length; i++) {
      var arr = STColor.values[i].toString().split(colorPrefix);
      var currentColorName = arr.length <= 1
          ? 'NOT FOUND'
          : (arr[1][0].toString() + arr[1].substring(1));
      if (colorName.toUpperCase() == (currentColorName).toUpperCase()) {
        return STColor.values[i];
      }
    }
    return STColor.red;
  }

  static Color getColor(
      {STColor color = STColor.background, Color tmp = Colors.black}) {
    switch (color) {
      case STColor.placeHolder:
        return const Color(0xFFE8E8E8);

      case STColor.buttonColor:
        return const Color(0xFF24A0ED);

      case STColor.mainColor:
        return const Color(0xFFA3423C);

      case STColor.appBarColor:
        return const Color(0xFFDE834D);

      case STColor.none:
        return const Color.fromRGBO(0, 0, 0, 0);

      // case STColor.statusInPlanning:
      //   return const Color(0xFF00FFFF);
      //

      case STColor.statusSpecialist:
        return const Color(0xFF0f4ddb);

      case STColor.transparent:
        return const Color.fromRGBO(0, 0, 0, 0);

      case STColor.darkOrange:
        return const Color(0xFFff8c00);

      case STColor.blurDarkOrange:
        return const Color(0x33ff8c00);

      case STColor.white:
        return const Color(0xFFFFFFFF);

      case STColor.green:
        return const Color(0xFF009966);

      case STColor.lightGreen:
        return const Color(0xFF00ff00);

      case STColor.green60:
        return const Color(0x99009966);

      case STColor.blueButton:
        return const Color(0xFF003366);

      case STColor.blueAccent:
        return Colors.blueAccent.shade700;

      case STColor.grey:
        return Colors.grey;

      case STColor.type:
        return Colors.indigo.shade400;

      case STColor.lightGrey:
        return Colors.grey.shade200;

      case STColor.statusFixed:
      case STColor.notificationFixed:
        return const Color(0xFF008E51);

      case STColor.statusFixedMap:
        return const Color(0x99008E51);

      case STColor.greyBackground:
        return Colors.grey.shade300;

      case STColor.statusRepairing:
      case STColor.notificationRepairing:
      case STColor.yellow:
      case STColor.background:
        return const Color(0xFFFFB10D);

      case STColor.statusRepairingMap:
        return const Color(0x99FFB10D);

      case STColor.statusInPlanning:
      case STColor.notificationInPlanning:
        return const Color(0xFF2fadad);

      case STColor.red60:
        return const Color(0x99D81C17);

      case STColor.red:
      case STColor.statusPending:
      case STColor.notificationPending:
        return const Color(0xFFD81C17);

      case STColor.statusComplete:
        return const Color(0xFF4E9F3D);

      case STColor.statusInProgress:
        return const Color(0xFFe0cc16);

      case STColor.statusPendingMap:
        return const Color(0x99D81C17);

      case STColor.stawberry:
        return const Color(0xFFFFA5A9);

      case STColor.black60:
      case STColor.statusDeclined:
      case STColor.notificationDeclined:
      case STColor.notificationReward:
        return const Color(0x99000000);

      case STColor.statusInvalid:
      case STColor.notificationComment:
      case STColor.black:
      default: //RCFontColor.black:
        return const Color(0xFF000000);
    }
  }
}
