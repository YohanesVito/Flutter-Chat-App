
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/constants/text_theme.dart';

class ChatAppTheme{
  ChatAppTheme._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: ChatTextTheme.lightTextTheme,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: ChatTextTheme.darkTextTheme,
  );
}