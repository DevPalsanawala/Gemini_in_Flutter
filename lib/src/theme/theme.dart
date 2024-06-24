import 'package:flutter/material.dart';
import 'package:myapp/src/constants/color.dart';
import 'package:myapp/src/theme/widget_theme/appbar_theme.dart';
import 'package:myapp/src/theme/widget_theme/elevatedbutton_theme.dart';
import 'package:myapp/src/theme/widget_theme/outlinebutton_theme.dart';
import 'package:myapp/src/theme/widget_theme/textfromfield_theme.dart';
import 'package:myapp/src/theme/widget_theme/texttheme.dart';

class DAppTheme {
  DAppTheme._();
  static ThemeData lighttheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.deepOrange,
    textTheme: DtextTheme.lightTextTheme,
    outlinedButtonTheme: DOutlineButtonTheme.lightOutlineButtonTheme,
    elevatedButtonTheme: DelevatedButtonTheme.lightelevatedButtonTheme,
    inputDecorationTheme: Dtextformfield.lightInputdecoration,
    appBarTheme: DAppbarTheme.lightAppbarTheme,
    // iconTheme: IconThemeData(color: dSecondaryColor),
  );
  static ThemeData darktheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.deepOrange,
    textTheme: DtextTheme.darkTextTheme,
    outlinedButtonTheme: DOutlineButtonTheme.darkOutlineButtonTheme,
    elevatedButtonTheme: DelevatedButtonTheme.darkelevatedButtonTheme,
    inputDecorationTheme: Dtextformfield.darkInputdecoration,
    appBarTheme: DAppbarTheme.darkAppbarTheme,
    // iconTheme: IconThemeData(color: dPrimaryColor),
  );
}
