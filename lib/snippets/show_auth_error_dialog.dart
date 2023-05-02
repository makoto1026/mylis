import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/main.dart';
import 'package:mylis/provider/session_provider.dart';
import 'package:mylis/snippets/url_launcher.dart';

Future<void> showAuthErrorDialog(Reader read, String content) async {
  showDialog(
    context: read(navKeyProvider).currentContext!,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("ログインできません"),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("戻る"),
          ),
          TextButton(
            onPressed: () async => {
              openMailApp(),
            },
            child: const Text("問い合わせる"),
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
