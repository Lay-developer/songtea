import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

////////
///Tablet size
bool isTable = Device.get().isTablet;
bool isIphoneX = Device.get().isIphoneX;
bool isIpad = false;

double wPaddingAll = 0.03;
double iPadSize = 1.0;

Color btnColor = const Color(0xFFDE834D);
Color appBarColor = const Color(0xFF781D42);
Color normalTextColor = const Color(0xFF000000);
Color btnTextColor = Colors.white;
Color errorTextColor = const Color(0xFFA13333);

///////////////////////
///font size
double titleTextSize = 0;
double descTextSize = 0;
double textBoxHeight = 0;
double normalTextSize = 0;

/////////////////////
///width & height of phone
double mainWidth = 0;
double mainHeight = 0;

double iconSize = 0.17;
double iconSizeBig = 0.25;

/// logo size w amd h
double logoSize = 0.4;

/// button size  w
double buttonSizeWidth = 0.018;

/// check box size
double checkBoxSize = 0.049;

String passwordMatch = '';

/// image cache
ImageCache myImageCache = ImageCache();

/////////////////
/// login page
///
double heightTopToLogo = 0.1;
double heightTopBar = 0.12;
double heightLogoToTextBox = 0.096;

//// height textbox to button in login form
double lHTextBoxToButton = 0.037;
double heightButtonToIcon = 0.0134;
double heightIconToText = 0.04;

/////////////////////
///Avatar
double avatarSizeBig = 0.1;
double avatarSizeMedium = 0.11;
double avatarSizeSmall = 0.060;

//// button
///
double heightButton = 0.06;

int emailLeng = 30;

int passwordLeng = 15;

int nameLeng = 50;

double menuIconSize = 0.07;

//////////////////////
/// Text box size
double textboxWidth = 0.82;
double textboxHeight = 0.14;
double textboxMarginBottom = 0.027;
double textboxMarginBottomDouble = 0.05;
double textboxPadding = 0.030;

//////////////////////
/// Logo
///
double logoWidth = 0.44;
double logoHeight = 0.44;
double logoMarginBottom = 0.04;

/////////////////////
///Page Padding
double pagePaddingTop = 0.08;
double pagePaddingLeftRight = 0.09;
