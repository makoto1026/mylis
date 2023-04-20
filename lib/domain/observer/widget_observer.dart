import 'package:flutter/cupertino.dart';
import 'package:mylis/presentation/util/banner.dart';
import 'package:mylis/provider/admob_provider.dart';

class MyWidgetsBindingObserver extends WidgetsBindingObserver {
  final admobProvider = AdmobProvider();

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      await admobProvider.runWithRetry(() async {
        // 広告のリクエストを実行する処理
        setBanner();
      });
    }
  }
}
