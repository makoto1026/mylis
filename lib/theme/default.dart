import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:mylis/theme/color.dart';

final themeProvider = Provider.family<ThemeData, BuildContext>(
  (ref, context) => ThemeData(
    fontFamily: "MPLUS1p",
    scaffoldBackgroundColor: Colors.white,
    textTheme: Theme.of(context).textTheme.apply(bodyColor: ThemeColor.black),
    dividerTheme: Theme.of(context).dividerTheme.copyWith(
          color: const Color(0xffEEE7E7),
          thickness: 1,
          space: 0,
        ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
        color: ThemeColor.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
);
