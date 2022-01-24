import 'package:flutter/material.dart';
import 'package:song_tea_app/helper/st_variable.dart';
import 'package:song_tea_app/pages/introduction_view.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ////////////////////
    ///initialize width, height, ipadsize,
    // mainWidth = MediaQuery.of(context).size.width;
    // mainHeight = MediaQuery.of(context).size.height;

    textBoxHeight = mainWidth * wPaddingAll;
    iPadSize = isIpad ? 0.75 : 1;
    updateSizeiPad();

    return const MaterialApp(
      home: IntroductionView(),
      debugShowCheckedModeBanner: false,
    );
  }

  void updateSizeiPad() {
    /// padding all width
    wPaddingAll = 0.038 * iPadSize;

    /// ok
    /// icon width and height
    iconSize = 0.17 * iPadSize;
    iconSizeBig = 0.25 * iPadSize;

    /// logo size w amd h
    logoSize = 0.4 * iPadSize;

    /// button size  w
    buttonSizeWidth = 0.018 * iPadSize;

    /// check box size
    checkBoxSize = 0.049 * iPadSize;

    /////////////////
    /// login page
    ///
    heightTopToLogo = 0.1 * iPadSize;
    heightTopBar = 0.12 * iPadSize;
    heightLogoToTextBox = 0.096 * iPadSize;

    //// height textbox to button in login form
    lHTextBoxToButton = 0.037 * iPadSize;
    heightButtonToIcon = 0.0134 * iPadSize;
    heightIconToText = 0.04 * iPadSize;

    /////////////////////
    ///Avatar
    avatarSizeBig = 0.1 * iPadSize;
    avatarSizeMedium = 0.11 * iPadSize;
    avatarSizeSmall = 0.060 * iPadSize;

    //// button
    ///
    heightButton = 0.06 * iPadSize;
    menuIconSize = 0.07 * iPadSize;

    //////////////////////
    /// Text box size
    textboxWidth = 0.82 * iPadSize;
    textboxHeight = 0.14 * iPadSize;
    textboxMarginBottom = 0.027 * iPadSize;
    textboxMarginBottomDouble = 0.05 * iPadSize;
    textboxPadding = 0.030 * iPadSize;

    //////////////////////
    /// Logo
    ///
    logoWidth = 0.44 * iPadSize;
    logoHeight = 0.44 * iPadSize;
    logoMarginBottom = 0.04 * iPadSize;

    /////////////////////
    ///Page Padding
    pagePaddingTop = 0.08 * iPadSize;
    pagePaddingLeftRight = 0.09 * iPadSize;
  }
}
