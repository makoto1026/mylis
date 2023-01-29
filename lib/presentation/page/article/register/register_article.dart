import 'package:flutter/material.dart';
import 'package:mylis/theme/mixin.dart';

class RegisterArticlePage extends StatelessWidget {
  const RegisterArticlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '記事登録',
          style: pageHeaderTextStyle,
        ),
      ),
      body: const Center(
        child: Text(
          '記事登録',
          style: TextStyle(fontSize: 32.0),
        ),
      ),
    );
  }
}
