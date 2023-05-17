import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/main.dart';
import 'package:mylis/provider/session_provider.dart';
import 'package:mylis/snippets/url_launcher.dart';
import 'package:mylis/theme/font_size.dart';

Future<void> showAuthErrorDialog(Reader read, String content) async {
  showDialog(
    context: read(navKeyProvider).currentContext!,
    builder: (BuildContext context) {
      final screenWidth = MediaQuery.of(context).size.width;
      final isTablet = screenWidth > 600;
      return AlertDialog(
        title: Text(
          "ログインできません",
          style: TextStyle(
            fontSize: isTablet
                ? ThemeFontSize.tabletNormalFontSize
                : ThemeFontSize.normalFontSize,
          ),
        ),
        content: Text(
          content,
          style: TextStyle(
            fontSize: isTablet
                ? ThemeFontSize.tabletNormalFontSize
                : ThemeFontSize.normalFontSize,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "戻る",
              style: TextStyle(
                fontSize: isTablet
                    ? ThemeFontSize.tabletNormalFontSize
                    : ThemeFontSize.normalFontSize,
              ),
            ),
          ),
          TextButton(
            onPressed: () async => {
              openMailApp(),
            },
            child: Text(
              "問い合わせる",
              style: TextStyle(
                fontSize: isTablet
                    ? ThemeFontSize.tabletNormalFontSize
                    : ThemeFontSize.normalFontSize,
              ),
            ),
          ),
        ],
      );
    },
  ).whenComplete(
    () => {
      read(sessionProvider.notifier).signOut(),
    },
  );
}
