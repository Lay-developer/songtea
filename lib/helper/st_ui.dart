import 'package:flutter/material.dart';
import 'package:song_tea_app/helper/st_color.dart';
import 'package:song_tea_app/helper/st_text.dart';

class UI {
  static void getSnackBar(
      {required BuildContext context,
      required Icon icon,
      required String description,
      bool isError = false,
      bool isSuccess = false,
      int duration = 10,
      required Widget trailing}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: ClsSTColor.getColor(
          color: isError
              ? STColor.statusRepairing
              : isSuccess
                  ? STColor.mainColor
                  : STColor.appBarColor),
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          Expanded(
            child: STText(
              text: description,
              stColor: STColor.appBarColor,
              fontSize: STFontSize.medium,
              maxLines: 2,
            ),
          )
        ],
      ),
      duration: Duration(seconds: duration),
    ));
  }
}
