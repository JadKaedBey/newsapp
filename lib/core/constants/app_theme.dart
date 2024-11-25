import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  cardColor: Colors.white,
  scaffoldBackgroundColor: Colors.grey[100],
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.blue,
  cardColor: Colors.grey[900], 
  scaffoldBackgroundColor: Colors.black, 
);
