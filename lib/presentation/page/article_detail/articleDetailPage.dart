import 'package:flutter/material.dart';
import 'package:mylis/theme/mixin.dart';

class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '記事詳細',
          style: pageHeaderTextStyle,
        ),
      ),
      body: const Center(
        child: Text(
          '記事詳細',
          style: TextStyle(fontSize: 32.0),
        ),
      ),
    );
  }
}
