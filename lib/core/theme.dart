import 'package:evently/core/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.lightBGColor,
    primaryColor: AppColors.lightPrimaryColor,
    dividerColor: AppColors.lightDividerColor,
    primaryColorLight: AppColors.white,
    primaryColorDark: AppColors.lightPrimaryColor,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(

      ),
      filled: true,
      fillColor: AppColors.white,

      hintStyle:TextStyle(
        color: AppColors.lightGreyColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.lightDividerColor,
          )
      ),
      focusedBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.lightDividerColor,
          )
      ) ,
     errorBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Colors.red
          )
      ) ,
    ),
   elevatedButtonTheme: ElevatedButtonThemeData(
       style: ElevatedButton.styleFrom(
         textStyle:TextStyle(
         color: AppColors.white,
           fontWeight: FontWeight.w500,
           fontSize: 20,),
         backgroundColor: AppColors.lightPrimaryColor,
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(16),
         ),
       ),
       ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: AppColors.lightTextColor,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),

      titleMedium: TextStyle(
        color: AppColors.lightPrimaryColor,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),

      titleSmall: TextStyle(
        color: AppColors.lightTextFieldColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,

      ),

      bodyMedium: TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      ),

      bodySmall: TextStyle(
        color: AppColors.lightGreyColor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.darkBGColor,
    primaryColor: AppColors.darkPrimaryColor,
    dividerColor: AppColors.darkDividerColor,
    primaryColorLight: AppColors.darkBlueColor,
    primaryColorDark: AppColors.white,
    hintColor: AppColors.lightTextFieldColor,

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(

      ),
      filled: true,
      fillColor: AppColors.darkBlueColor,
      hintStyle:  TextStyle(
        color: AppColors.darkTextFieldColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.darkDividerColor,
          )
      ),
      focusedBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.darkDividerColor,
          )
      ) ,
      errorBorder:OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
              color: Colors.red
          )

      ) ,
    ),


    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle:TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.w500,
          fontSize: 20,),
        backgroundColor: AppColors.darkPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
    buttonTheme: ButtonThemeData(
       shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(16),
       ),
      buttonColor: AppColors.darkPrimaryColor
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: AppColors.darkTextColor,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),

      titleMedium: TextStyle(
        color: AppColors.darkPrimaryColor,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        color: AppColors.darkTextFieldColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),

      bodyMedium: TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      ),

      bodySmall: TextStyle(
        color: AppColors.darkGreyColor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}