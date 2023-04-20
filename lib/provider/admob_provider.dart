import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdmobProvider extends StateNotifier<bool> {
  AdmobProvider() : super(false);

  static const int maxRetryCount = 3;
  static const Duration retryDuration = Duration(seconds: 5);

  int _retryCount = 0;

  Future<void> runWithRetry(Function adRequestFunc) async {
    try {
      // 広告のリクエストを実行する
      await adRequestFunc();
      // 成功した場合は true を返す
      state = true;
    } catch (e) {
      // 失敗した場合はリトライを試みる
      if (_retryCount < maxRetryCount) {
        await Future.delayed(retryDuration);
        _retryCount++;
        return await runWithRetry(adRequestFunc);
      }
      // リトライ回数が上限に達した場合は false を返す
      state = false;
    }
  }
}

final admobProvider = StateNotifierProvider.autoDispose<AdmobProvider, bool>(
  (ref) => AdmobProvider(),
);
