import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoadingStateProvider extends StateNotifier<bool> {
  LoadingStateProvider() : super(false);

  Future<void> startLoading() async {
    state = true;
  }

  Future<void> stopLoading() async {
    state = false;
  }
}

final loadingStateProvider = StateNotifierProvider<LoadingStateProvider, bool>(
    (ref) => LoadingStateProvider());
