import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:song_tea_app/helper/st_color.dart';
import 'package:song_tea_app/helper/st_text.dart';
import 'package:song_tea_app/helper/st_validation.dart';
import 'package:song_tea_app/helper/st_variable.dart';

String pattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z ]{2,}))$';

enum STTextFormFieldValidationRules {
  text,
  name,
  number,
  email,
  phone,
  password,
  confirmPassword,
  activation,
  custom,
  emailOrPhone,
  multiline,
  note,
  singlelineLongText,
  oldPassword,
}

class STTextFormField extends StatelessWidget {
  final STTextFormFieldValidationRules validationRules;
  final bool isShowBorder;
  final bool isChangePassword;
  final bool isRequired;
  final bool isAutofocus;
  final bool enabled;
  final AutovalidateMode autoValidateMode;
  final bool isAutoCorrect;
  final bool isTextChange;
  final bool isObSecure;

  final int inputFormatter;
  final String labelDesc;
  final STColor labelColor;
  final STColor textColor;
  final String iconImage;
  final STColor borderColor;
  final STFontFamily fontFamily;
  final STFontSize fontSize;
  final FontWeight fontWeight;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String defaultValue;
  final TextInputType? inputType;
  final TextAlign textAlign;

  final ValueChanged<String?>? onSaved;
  final ValueChanged<Map<String, String>>? onValidating;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onShowPassword;
  final ValueChanged<bool>? onTextChange;
  final Function()? onTap;
  final ValueChanged<String>? onChange;
  const STTextFormField(
      {Key? key,
      this.validationRules = STTextFormFieldValidationRules.text,
      this.isShowBorder = false,
      this.isChangePassword = false,
      this.isRequired = true,
      this.isAutofocus = false,
      this.enabled = true,
      this.autoValidateMode = AutovalidateMode.disabled,
      this.isAutoCorrect = true,
      this.isTextChange = false,
      this.isObSecure = false,
      this.inputFormatter = 50,
      this.labelDesc = '',
      this.labelColor = STColor.black,
      this.textColor = STColor.black,
      this.iconImage = '',
      this.borderColor = STColor.black,
      this.fontFamily = STFontFamily.quicksan,
      this.controller,
      this.focusNode,
      this.defaultValue = '',
      this.inputType,
      this.onSaved,
      this.onValidating,
      this.onEditingComplete,
      this.onFieldSubmitted,
      this.onShowPassword,
      this.onTextChange,
      this.onTap,
      this.onChange,
      this.fontSize = STFontSize.medium,
      this.fontWeight = FontWeight.normal,
      this.textAlign = TextAlign.left})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextInputType _textInputType = TextInputType.text;
    TextInputAction _textInputAction = TextInputAction.continueAction;
    TextStyle _style = STText.getTextStyle(
        fontFamily: STFontFamily.quicksan,
        fontSize: fontSize,
        fontWeight: fontWeight);
    // TextAlign _align = TextAlign.left;
    int _intMaxTextLength = 50;

    if (validationRules == STTextFormFieldValidationRules.number) {
      _textInputType = TextInputType.number;
    } else if (validationRules == STTextFormFieldValidationRules.text) {
      _textInputType = TextInputType.text;
    } else if (validationRules == STTextFormFieldValidationRules.email) {
      _textInputType == TextInputType.emailAddress;
    } else if (validationRules == STTextFormFieldValidationRules.name) {
      _textInputType = TextInputType.text;
      _intMaxTextLength = 25;
    } else if (validationRules == STTextFormFieldValidationRules.oldPassword) {
      _textInputType = TextInputType.text;
    } else if (validationRules == STTextFormFieldValidationRules.password) {
      _textInputType = TextInputType.text;
    } else if (validationRules == STTextFormFieldValidationRules.multiline) {
      _textInputType = TextInputType.text;
      _intMaxTextLength = 200;
    } else if (validationRules ==
        STTextFormFieldValidationRules.confirmPassword) {
      _textInputType = TextInputType.text;
    } else if (validationRules == STTextFormFieldValidationRules.note) {
      _textInputType = TextInputType.text;
      _intMaxTextLength = 500;
    } else {
      _textInputType = TextInputType.text;
      _intMaxTextLength;
    }

    if (controller != null) {
      controller!.addListener(() {
        // print('controller.text: ${controller.text}');
        if (controller!.text.isNotEmpty) {
          onTextChange!(true);
        } else {
          onTextChange!(false);
        }
      });
    }

    return Container(
      alignment: Alignment.center,
      child: TextFormField(
        focusNode: focusNode,
        autocorrect: isAutoCorrect,
        autofocus: isAutofocus,
        autovalidateMode: autoValidateMode,
        controller: controller,
        decoration: _generateInputDecoration(labelDesc, labelColor, context),
        style: _style,
        enabled: enabled,
        inputFormatters: [LengthLimitingTextInputFormatter(_intMaxTextLength)],
        key: key,
        enableInteractiveSelection: true,
        textAlign: textAlign,
        textCapitalization: TextCapitalization.none,
        keyboardType: _textInputType,
        textInputAction: _textInputAction,
        initialValue: controller == null ? defaultValue : null,
        validator: (value) {
          _onTextFormFieldValidation(value!, context);
        },
        obscureText: isObSecure,
        onSaved: onSaved,
        onChanged: onChange,
        onTap: onTap,
        onFieldSubmitted: (value) {
          if (onFieldSubmitted != null) onFieldSubmitted!(value);
        },
        onEditingComplete: () {
          FocusScope.of(context).requestFocus(FocusNode());
          if (onEditingComplete != null) onEditingComplete!();
        },
      ),
    );
  }

  InputDecoration _generateInputDecoration(
      String labelText, STColor labelHint, BuildContext context) {
    final errorOutlineBorder = !isShowBorder
        ? null
        : OutlineInputBorder(
            borderSide: BorderSide(
                style: BorderStyle.solid,
                width: 1,
                color: ClsSTColor.getColor(color: STColor.red)),
            borderRadius: BorderRadius.circular(0));

    final normalOutlineBorder = !isShowBorder
        ? null
        : OutlineInputBorder(
            borderSide: BorderSide(
                style: BorderStyle.solid,
                width: 1,
                color: ClsSTColor.getColor(color: borderColor)),
            borderRadius: BorderRadius.circular(5));

    return InputDecoration(
      suffixIcon: enabled || isTextChange
          ? isChangePassword
              // show password
              ? IconButton(
                  iconSize: mainWidth * STSize.getDouble(STFontSize.medium),
                  onPressed: () {
                    if (onShowPassword != null) onShowPassword!();
                    // print(isShowPassword);
                  },
                  color: ClsSTColor.getColor(color: STColor.grey),
                  icon: Icon(
                      isObSecure ? Icons.visibility : Icons.visibility_off),
                )

              // clear text
              : IconButton(
                  iconSize: !isTextChange
                      ? 0
                      : mainWidth * STSize.getDouble(STFontSize.medium),
                  onPressed: () {
                    controller?.clear();
                  },
                  color: ClsSTColor.getColor(color: STColor.grey),
                  icon: const Icon(Icons.clear),
                )
          : Container(),
      fillColor: ClsSTColor.getColor(
          color: (!enabled && textColor == STColor.white)
              ? STColor.lightGrey
              : textColor),
      hintText: labelText,
      hintStyle: STText.getTextStyle(
          fontFamily: STFontFamily.quicksan,
          stColor: labelHint,
          fontWeight: fontWeight,
          fontSize: fontSize),
      enabledBorder: normalOutlineBorder,
      border: InputBorder.none,
      focusedBorder: normalOutlineBorder,
      focusedErrorBorder: errorOutlineBorder,
      errorBorder: errorOutlineBorder,
      contentPadding: EdgeInsets.all(mainWidth * textboxPadding),
      filled: !isShowBorder ? false : true,
    );
  }

  String? _onTextFormFieldValidation(String value, BuildContext context) {
    String errMsg = '';
    switch (validationRules) {

      ////////////////////
      /// email validation
      case STTextFormFieldValidationRules.email:
        RegExp regExp = RegExp(pattern);
        if (isRequired) {
          if (value.trim().isEmpty) {
            // errMsg = RCLanguage.translate(context, 'errInputEmailRequired');
          }
          if (!regExp.hasMatch(value)) {
            // errMsg = RCLanguage.translate(context, 'errInputEmail');
          }
        }

        break;

      ////////////////////
      /// phone validation
      case STTextFormFieldValidationRules.phone:
        final RegExp phoneExp = RegExp(r'(^[0-9]*$)');

        if (isRequired) {
          if (value.trim().length < 9) {
            // errMsg = RCLanguage.translate(context, 'errInputPhoneGE9');
          } else if (!phoneExp.hasMatch(value)) {
            // errMsg = RCLanguage.translate(context, 'errInputPhone09');
          }
        }

        break;

      ////////////////////
      /// name validation
      case STTextFormFieldValidationRules.name:
        // String pattern = r'(^[a-zA-Z0-9\s\_]*$)';
        // RegExp regExp = new RegExp(pattern);

        if (value.length < 4) {
          // errMsg = RCLanguage.translate(context, 'errInputNameGE4');
        }
        // else if (!regExp.hasMatch(value))
        //   this._errMsg = RCLanguage.translate(context, 'errInputNameAZ');

        break;

      ////////////////////
      /// password validation
      case STTextFormFieldValidationRules.password:
        passwordMatch = value;
        String pattern = r'(^[a-zA-Z0-9\s]*$)';
        RegExp regExp = RegExp(pattern);
        if (value.length < 6) {
          // errMsg = RCLanguage.translate(context, 'errInputPasswordGE6');
        } else if (!regExp.hasMatch(value)) {
          // errMsg = RCLanguage.translate(context, 'errInputPasswordAZ');
        }

        break;

      //////
      /// confirm password validation
      case STTextFormFieldValidationRules.confirmPassword:
        if (value != passwordMatch) {
          // errMsg =
          //     RCLanguage.translate(context, 'errInputConfirmPasswordMatch');
        }

        break;

      ////////////////////
      /// activate validation
      case STTextFormFieldValidationRules.activation:
        String pattern = r'(^[0-9]*$)';
        RegExp regExp = RegExp(pattern);
        if (value.length < 6) {
          // errMsg = RCLanguage.translate(context, 'errInputActivation6');
        } else if (!regExp.hasMatch(value)) {
          // errMsg = RCLanguage.translate(context, 'errInputActivation09');
        }

        break;

      ////////////////////
      /// custom validation
      case STTextFormFieldValidationRules.custom:
        break;

      ////////////////////
      /// email or phone in one box validation
      case STTextFormFieldValidationRules.emailOrPhone:
        final RegExp phoneExp = RegExp(r'(^[0-9]*$)');

        if (isRequired) {
          /// check number or not
          if (STValidation.isNumber(value)) {
            /// is number
            if (value.trim().length < 9) {
              // errMsg = RCLanguage.translate(context, 'errInputPhoneGE9');
            } else if (!phoneExp.hasMatch(value)) {
              // errMsg = RCLanguage.translate(context, 'errInputPhone09');
            }
          } else {
            /// not number is email
            RegExp regExp = RegExp(pattern);

            if (isRequired && value.trim().isEmpty) {
              // errMsg = RCLanguage.translate(context, 'errInputEmailRequired');
            }
            if (!regExp.hasMatch(value)) {
              // errMsg = RCLanguage.translate(context, 'errInputEmail');
            }
          }
        } else {
          if (STValidation.isNumber(value)) {
            if (value.trim().isNotEmpty && !phoneExp.hasMatch(value)) {
              // errMsg = RCLanguage.translate(context, 'errInputPhone09');
            }
          }
        }

        break;

      ////////////////////
      /// multiline validation
      case STTextFormFieldValidationRules.multiline:
        break;

      ////////////////////
      /// Other case
      default:

        ///If reached, assume that your application is abnormally functioned!
        // errMsg = RCLanguage.translate(context, 'errInputUnexpect');
        break;
    }

    Map<String, String> responseMap = <String, String>{};
    responseMap['value'] = value;
    responseMap['error'] = errMsg;
    if (errMsg == '') {
      if (onValidating != null) onValidating!(responseMap);
      return null;
    }

    if (onValidating != null) onValidating!(responseMap);
    return '';
  }
}
