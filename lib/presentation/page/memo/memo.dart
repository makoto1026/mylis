import 'package:flutter/material.dart';
import 'package:mylis/theme/mixin.dart';

class MemoPage extends StatelessWidget {
  const MemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'メモ',
          style: pageHeaderTextStyle,
        ),
      ),
      body: const Center(
        child: Text(
          'メモ',
          style: TextStyle(fontSize: 32.0),
        ),
      ),
    );
  }
}
