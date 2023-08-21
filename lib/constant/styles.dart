// ignore_for_file: file_names, prefer_const_constructors

import 'package:bionmed_app/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

double scale = Get.width <= 320 ? 0.75 : 1;

double defaultPadding = 24.0;

class BorderStyles {
  static Border borderGrey =
      Border.all(color: Colors.grey.withOpacity(0.4), width: 1.5);
  static Border borderPrimary =
      Border.all(color: AppColor.primaryColor, width: 1.5);

  static OutlineInputBorder enableTextField = OutlineInputBorder(
    borderSide:
        BorderSide(color: AppColor.bodyColor.shade300, width: Strokes.xthin),
    borderRadius: Corners.lgBorder,
  );

  static OutlineInputBorder focusTextField = OutlineInputBorder(
    borderSide: BorderSide(color: AppColor.bluePrimary2, width: Strokes.thin),
    borderRadius: Corners.lgBorder,
  );

  static OutlineInputBorder disableTextField = OutlineInputBorder(
    borderSide:
        BorderSide(color: AppColor.bodyColor.shade300, width: Strokes.xthin),
    borderRadius: Corners.lgBorder,
  );

  static OutlineInputBorder errorTextField = OutlineInputBorder(
    borderSide: BorderSide(color: AppColor.secondColor, width: Strokes.thin),
    borderRadius: Corners.lgBorder,
  );
}

InputDecoration inputDecoration(
    {required String hintText, Widget? prefixIcon, Widget? suffixIcon}) {
  return InputDecoration(
      isDense: true,
      filled: true,
      fillColor: AppColor.whiteColor,
      contentPadding:
          EdgeInsets.symmetric(horizontal: Insets.med, vertical: Insets.med),
      hintText: hintText,
      border: BorderStyles.enableTextField,
      focusedBorder: BorderStyles.focusTextField,
      enabledBorder: BorderStyles.enableTextField,
      errorBorder: BorderStyles.errorTextField,
      disabledBorder: BorderStyles.disableTextField,
      errorMaxLines: 5,
      prefixIcon: prefixIcon,
      prefixIconConstraints:
          BoxConstraints(minHeight: Sizes.lg, minWidth: Sizes.xl),
      suffixIconConstraints:
          BoxConstraints(minHeight: Sizes.lg, minWidth: Sizes.lg),
      suffixIcon: suffixIcon,
      hintStyle: TextStyles.body2.copyWith(color: AppColor.bodyColor.shade500));
}

Widget verticalSpace(double v) {
  return SizedBox(height: v);
}

Widget horizontalSpace(double v) {
  return SizedBox(width: v);
}

/// Used for all animations in the  app
class Times {
  static const Duration fastest = Duration(milliseconds: 150);
  static const fast = Duration(milliseconds: 250);
  static const medium = Duration(milliseconds: 350);
  static const slow = Duration(milliseconds: 700);
  static const slower = Duration(milliseconds: 1000);
}

class Sizes {
  static double get xs => 8 * scale;
  static double get sm => 12 * scale;
  static double get med => 20 * scale;
  static double get lg => 32 * scale;
  static double get xl => 48 * scale;
  static double get xxl => 80 * scale;
}

class IconSizes {
  static double get sm => 16 * scale;
  static double get med => 24 * scale;
  static double get lg => 32 * scale;
  static double get xl => 48 * scale;
  static double get xxl => 60 * scale;
}

class Insets {
  static double offsetScale = 1;
  static double get xs => 4 * scale;
  static double get sm => 8 * scale;
  static double get med => 12 * scale;
  static double get lg => 16 * scale;
  static double get xl => 20 * scale;
  static double get xxl => 32 * scale;
  // Offset, used for the edge of the window, or to separate large sections in the app
  static double get offset => 40 * offsetScale;
}

class Corners {
  static double sm = 3 * scale;
  static BorderRadius smBorder = BorderRadius.all(smRadius);
  static Radius smRadius = Radius.circular(sm);

  static double med = 5 * scale;
  static BorderRadius medBorder = BorderRadius.all(medRadius);
  static Radius medRadius = Radius.circular(med);

  static double lg = 8 * scale;
  static BorderRadius lgBorder = BorderRadius.all(lgRadius);
  static Radius lgRadius = Radius.circular(lg);

  static double xl = 16 * scale;
  static BorderRadius xlBorder = BorderRadius.all(xlRadius);
  static Radius xlRadius = Radius.circular(xl);

  static double xxl = 24 * scale;
  static BorderRadius xxlBorder = BorderRadius.all(xxlRadius);
  static Radius xxlRadius = Radius.circular(xxl);
}

class Strokes {
  static const double xthin = 0.7;
  static const double thin = 1;
  static const double med = 2;
  static const double thick = 4;
}

class Shadows {
  static List<BoxShadow> get universal => [
        BoxShadow(
            color: const Color(0xff333333).withOpacity(.13),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 5)),
      ];
  static List<BoxShadow> get small => [
        BoxShadow(
            color: const Color(0xff333333).withOpacity(.15),
            spreadRadius: 0,
            blurRadius: 3,
            offset: const Offset(0, 1)),
      ];
  static List<BoxShadow> get none => [
        BoxShadow(
            color: AppColor.bodyColor.shade50,
            spreadRadius: 0,
            blurRadius: 0,
            offset: const Offset(0, 0)),
      ];

  static List<BoxShadow> get shadowsUp => [
        BoxShadow(
            color: const Color(0xff333333).withOpacity(.15),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(-1, 0)),
      ];
}

/// Font Sizes
/// You can use these directly if you need, but usually there should be a predefined style in TextStyles.
class FontSizes {
  /// Provides the ability to nudge the app-wide font scale in either direction
  static double get s9 => 9 * scale;
  static double get s10 => 10 * scale;
  static double get s11 => 11 * scale;
  static double get s12 => 12 * scale;
  static double get s14 => 14 * scale;
  static double get s16 => 16 * scale;
  static double get s18 => 18 * scale;
  static double get s20 => 20 * scale;
  static double get s26 => 26 * scale;
  static double get s32 => 32 * scale;
  static double get s40 => 40 * scale;
  static double get s56 => 56 * scale;
}

/// Fonts - A list of Font Families, this is uses by the TextStyles class to create concrete styles.

/// TextStyles - All the core text styles for the app should be declared here.
/// Don't try and create every variant in existence here, just the high level ones.
/// More specific variants can be created on the fly using `style.copyWith()`
/// `newStyle = TextStyles.body1.copyWith(lineHeight: 2, color: Colors.red)`
class TextStyles {
  /// Declare a base style for each Family
  static const TextStyle inter =
      TextStyle(fontWeight: FontWeight.w400, height: 1, fontFamily: 'Inter');

  static TextStyle get h1 => inter.copyWith(
      fontWeight: FontWeight.w700,
      fontSize: FontSizes.s56,
      letterSpacing: -1,
      height: 1.17);
  static TextStyle get h2 =>
      h1.copyWith(fontSize: FontSizes.s40, letterSpacing: -.5, height: 1.16);
  static TextStyle get h3 => h1.copyWith(
        fontSize: FontSizes.s32,
        letterSpacing: -.05,
        height: 1.29,
      );
  static TextStyle get h4 =>
      h1.copyWith(fontSize: FontSizes.s26, fontFamily: 'Ubuntu');
  static TextStyle get h5 =>
      h1.copyWith(fontSize: FontSizes.s20, fontFamily: 'Ubuntu');
  static TextStyle get h6 =>
      h3.copyWith(fontSize: FontSizes.s18, fontFamily: 'Ubuntu');
  static TextStyle get subtitle1 => inter.copyWith(
      fontWeight: FontWeight.bold,
      fontSize: FontSizes.s16,
      height: 1.31,
      fontFamily: 'Ubuntu');
  static TextStyle get title1 => inter.copyWith(
      fontWeight: FontWeight.normal,
      fontSize: FontSizes.s16,
      height: 0.9,
      fontFamily: 'Ubuntu');
  static TextStyle get subtitle2 => subtitle1.copyWith(
      fontWeight: FontWeight.w700,
      fontSize: FontSizes.s14,
      height: 1.36,
      fontFamily: 'Ubuntu');
  static TextStyle get subtitle3 => inter.copyWith(
      fontWeight: FontWeight.normal,
      fontSize: FontSizes.s14,
      height: 1.31,
      fontFamily: 'Ubuntu');
  static TextStyle get body1 => inter.copyWith(
      fontWeight: FontWeight.normal,
      fontSize: FontSizes.s16,
      height: 1.71,
      fontFamily: 'Ubuntu');
  static TextStyle get body2 => body1.copyWith(
      fontSize: FontSizes.s14,
      height: 1.5,
      letterSpacing: .2,
      fontFamily: 'Ubuntu');
  static TextStyle get small1 => inter.copyWith(
      fontSize: FontSizes.s12,
      fontWeight: FontWeight.normal,
      height: 1.15,
      fontFamily: 'Ubuntu');
  static TextStyle get small2 =>
      inter.copyWith(fontSize: FontSizes.s10, fontWeight: FontWeight.normal);
  static TextStyle get callout1 => inter.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: FontSizes.s12,
      height: 1.17,
      fontFamily: 'Ubuntu',
      letterSpacing: .5);
  static TextStyle get callout2 => callout1.copyWith(
      fontSize: FontSizes.s10,
      height: 1,
      letterSpacing: .25,
      fontFamily: 'Ubuntu');
  static TextStyle get callout3 => callout1.copyWith(
      fontSize: FontSizes.s9,
      height: 1,
      letterSpacing: .25,
      fontFamily: 'Ubuntu');
  static TextStyle get caption => inter.copyWith(
      fontWeight: FontWeight.w500, fontSize: FontSizes.s11, height: 1.36);
  static TextStyle get button => inter.copyWith(
      fontWeight: FontWeight.bold, fontSize: FontSizes.s14, height: 1.71);
}

class Borders {
  static const BorderSide universalBorder = BorderSide(
    color: AppColor.bodyColor,
    width: 1,
  );

  static const BorderSide smallBorder = BorderSide(
    color: AppColor.bodyColor,
    width: 0.5,
  );

  static BoxDecoration borderPin({
    Color? borderColor,
    double? strokeWidth,
  }) {
    return BoxDecoration(
        color: AppColor.bodyColor.shade100,
        borderRadius: Corners.lgBorder,
        border: Border.all(
          width: strokeWidth ?? Strokes.xthin,
          color: borderColor ?? AppColor.bodyColor.shade300,
        ));
  }
}

// const titleTile = TextStyle(
//   color: AppColor.bodyColor,
//   fontSize: 16,
//   fontWeight: FontWeight.w700,
// );
