import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tractian_challenge/app/core/constants/app_dimensions.dart';

import '../../constants/app_font_size.dart';

const _defaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(AppDimensions.smallBorderRadius -1)),
    borderSide: BorderSide.none);

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromRGBO(23, 25, 45, 1),
      elevation: 0,
      iconTheme: IconThemeData(color: Color(0xffFFFFFF)),
      titleTextStyle: TextStyle(color: Color(0xffFFFFFF)),
      centerTitle: true,      
    ),
    actionIconTheme: ActionIconThemeData(
      backButtonIconBuilder: (context) =>  SvgPicture.asset('assets/icons/arrow_back.svg'),
    ),
    hintColor: const Color.fromRGBO(119, 129, 140, 1),
    
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      errorStyle: TextStyle(
        color: Color(0xffEB5757),
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ), 
      fillColor: Color(0xffF2F2F9),
      labelStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      border: _defaultInputBorder,
      focusedBorder: _defaultInputBorder,
      enabledBorder: _defaultInputBorder,
      errorBorder: _defaultInputBorder,
    ),
    colorScheme: const ColorScheme.light(
      primary: Color.fromRGBO(37, 99, 235, 1),
      secondary: Color.fromRGBO(33, 136, 255, 1),
      tertiary: Color.fromRGBO(23, 25, 45, 1),
      error: Color(0xffEB5757),
    ),
    textTheme: const TextTheme(     
      headlineLarge: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w700,
        fontSize: AppFontSize.large,
      ),  
      titleLarge: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: AppFontSize.extraLarge,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: AppFontSize.medium,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: AppFontSize.medium,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w700,
        fontSize: AppFontSize.medium,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w600,
        fontSize: AppFontSize.medium,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: AppFontSize.medium,
      ),
      labelLarge: TextStyle(
          fontFamily: 'Roboto', fontWeight: FontWeight.w700, fontSize: 1),
      labelMedium: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w600,
        fontSize: AppFontSize.small,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: AppFontSize.small,
      ),
    ),
    extensions: const [
      TractianColors(
        primary: Color.fromRGBO(37, 99, 235, 1),
        secondary: Color.fromRGBO(33, 136, 255, 1),
        tertiary: Color.fromRGBO(23, 25, 45, 1),
        error: Color(0xffEB5757),
        black: Color(0xff000000),
        appBackground: Color(0xffFFFFFF),
        textColor: Color(0xffFFFFFF),      
        grey: Color.fromRGBO(119, 129, 140, 1),
        iconColor: Color.fromARGB(255, 0, 0, 8),   
        white: Color(0xffFFFFFF),
        success: Color(0xff00FF85),   
      ),
    ],
  );
}

class TractianColors extends ThemeExtension<TractianColors> {
  const TractianColors({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.error,
    required this.success,   
    required this.black,
    required this.iconColor,
    required this.appBackground,
    required this.textColor,
    required this.white,   
    required this.grey,    
  });

  final Color primary;
  final Color secondary;
  final Color success;
  final Color tertiary;
  final Color error; 
  final Color black;
  final Color appBackground;
  final Color textColor; 
  final Color grey; 
  final Color white;  
  final Color iconColor;  

  static TractianColors of(BuildContext context) {
    return Theme.of(context).extension<TractianColors>()!;
  }

  @override
  ThemeExtension<TractianColors> copyWith({
    Color? primary,
    Color? secondary,
    Color? tertiary,
    Color? error,
    Color? success,
    Color? black,
    Color? appBackground,
    Color? textColor,  
    Color? grey,
    Color? white,
    Color? iconColor,
    
  }) {
    return TractianColors(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      tertiary: tertiary ?? this.tertiary,
      error: error ?? this.error,
      success: success ?? this.success,   
      black: black ?? this.black,
      appBackground: appBackground ?? this.appBackground,
      textColor: textColor ?? this.textColor,
      grey: grey ?? this.grey,
      white: white ?? this.white,
      iconColor: iconColor ?? this.black,

    );
  }

  @override
  ThemeExtension<TractianColors> lerp(
    covariant ThemeExtension<TractianColors>? other,
    double t,
  ) {
    if (other is! TractianColors) {
      return this;
    }

    return TractianColors(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      tertiary: Color.lerp(tertiary, other.tertiary, t)!,
      error: Color.lerp(error, other.error, t)!,
      success: Color.lerp(success, other.success, t)!,
      black: Color.lerp(black, other.black, t)!,
      appBackground: Color.lerp(appBackground, other.appBackground, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
      grey: Color.lerp(grey, other.grey, t)!,    
      white: Color.lerp(white, other.white, t)!,    
      iconColor: Color.lerp(iconColor, other.iconColor, t)!
    );
  }
}
