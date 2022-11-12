import 'package:budi/Utilities/TextStyling.dart';
import 'package:flutter/cupertino.dart';

Text getBoldText(
    {@required String? msg,
    double? fontSize,
    int? maxLines,
    TextAlign? textAlign,
    Color? color}) {
  return Text(msg!,
      maxLines: maxLines,
      textAlign: textAlign,
      style: CustomTextStyle.textFormFieldOpenSansBold
          .copyWith(color: color, fontSize: fontSize));
}

Text getBoldItalicText(
    {@required String? msg,
      double? fontSize,
      int? maxLines,
      TextAlign? textAlign,
      Color? color}) {
  return Text(msg!,
      maxLines: maxLines,
      textAlign: textAlign,
      style: CustomTextStyle.textFormFieldOpenSansBoldItalic
          .copyWith(color: color, fontSize: fontSize));
}


Text getExtraBoldStyleText(
    {@required String? msg,
    double? fontSize,
    int? maxLines,
    TextAlign? textAlign,
    Color? color}) {
  return Text(msg!,
      maxLines: maxLines,
      textAlign: textAlign,
      style: CustomTextStyle.textFormFieldOpenSansExtraBold
          .copyWith(color: color, fontSize: fontSize));
}

Text getExtraBoldItalicStyleText(
    {@required String? msg,
    double? fontSize,
    int? maxLines,
    TextAlign? textAlign,
    Color? color}) {
  return Text(msg!,
      maxLines: maxLines,
      textAlign: textAlign,
      style: CustomTextStyle.textFormFieldOpenSansExtraBoldItalic
          .copyWith(color: color, fontSize: fontSize));
}

Text getItalicText(
    {@required String? msg,
      double? fontSize,
      int? maxLines,
      TextAlign? textAlign,
      Color? color,
      TextDecoration? decoration}) {
  return Text(msg!,
      maxLines: maxLines,
      textAlign: textAlign,
      style: CustomTextStyle.textStyleOpenSansItalic
          .copyWith(color: color, fontSize: fontSize, decoration: decoration));
}

Text getLightStyleText(
    {@required String? msg,
    double? fontSize,
    int? maxLines,
    TextAlign? textAlign,
    Color? color}) {
  return Text(msg!,
      maxLines: maxLines,
      textAlign: textAlign,
      style: CustomTextStyle.textFormFieldOpenSansLight
          .copyWith(color: color, fontSize: fontSize));
}

Text getLightItalicText(
    {@required String? msg,
    double? fontSize,
    int? maxLines,
    TextAlign? textAlign,
    Color? color}) {
  return Text(msg!,
      maxLines: maxLines,
      textAlign: textAlign,
      style: CustomTextStyle.textFormFieldOpenSansLightItalic
          .copyWith(color: color, fontSize: fontSize));
}

Text getRegularStyleText(
    {@required String? msg,
    double? fontSize,
    int? maxLines,
    TextAlign? textAlign,
    Color? color}) {
  return Text(msg!,
      maxLines: maxLines,
      textAlign: textAlign,
      style: CustomTextStyle.textFormFieldOpenSansRegular
          .copyWith(color: color, fontSize: fontSize));
}

Text getSemiBoldText(
    {@required String? msg,
    double? fontSize,
    int? maxLines,
    TextAlign? textAlign,
    Color? color}) {
  return Text(msg!,
      maxLines: maxLines,
      textAlign: textAlign,
      style: CustomTextStyle.textFormFieldOpenSansSemibold
          .copyWith(color: color, fontSize: fontSize));
}



Text getSemiBoldItalicText(
    {@required String? msg,
      double? fontSize,
      int? maxLines,
      TextAlign? textAlign,
      Color? color}) {
  return Text(msg!,
      maxLines: maxLines,
      textAlign: textAlign,
      style: CustomTextStyle.textFormFieldOpenSansSemiboldItalic
          .copyWith(color: color, fontSize: fontSize));
}

// Text getGilroyLightStyleText(
//     {@required String? msg,
//       double? fontSize,
//       int? maxLines,
//       TextAlign? textAlign,
//       Color? color}) {
//   return Text(msg!,
//       maxLines: maxLines,
//       textAlign: textAlign,
//       style: CustomTextStyle.textFormFieldGILROYLight
//           .copyWith(color: color, fontSize: fontSize));
// }
//
// Text getGilroyMediumStyleText(
//     {@required String? msg,
//       double? fontSize,
//       int? maxLines,
//       TextAlign? textAlign,
//       Color? color}) {
//   return Text(msg!,
//       maxLines: maxLines,
//       textAlign: textAlign,
//       style: CustomTextStyle.textFormFieldGILROYMedium
//           .copyWith(color: color, fontSize: fontSize));
// }
//
// Text getGilroyRegularStyleText(
//     {@required String? msg,
//       double? fontSize,
//       int? maxLines,
//       TextAlign? textAlign,
//       Color? color}) {
//   return Text(msg!,
//       maxLines: maxLines,
//       textAlign: textAlign,
//       style: CustomTextStyle.textFormFieldGILROYRegular
//           .copyWith(color: color, fontSize: fontSize));
// }
//
// Text getGilroySemiBoldStyleText(
//     {@required String? msg,
//       double? fontSize,
//       int? maxLines,
//       TextAlign? textAlign,
//       Color? color}) {
//   return Text(msg!,
//       maxLines: maxLines,
//       textAlign: textAlign,
//       style: CustomTextStyle.textFormFieldGILROYSemiBOLD
//           .copyWith(color: color, fontSize: fontSize));
// }