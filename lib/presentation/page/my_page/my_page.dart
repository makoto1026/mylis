import 'package:flutter/material.dart';
import 'package:mylis/theme/mixin.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'マイページ',
          style: pageHeaderTextStyle,
        ),
      ),
      body: const Center(
        child: Text(
          'マイページ',
          style: TextStyle(fontSize: 32.0),
        ),
      ),
    );
  }
}
