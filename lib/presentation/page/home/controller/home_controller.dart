import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeProvider extends StateNotifier<int> {
  HomeProvider() : super(0);

  Future<void> set(int index) async {
    state = index;
  }
}

final homeProvider = StateNotifierProvider.autoDispose<HomeProvider, int>(
  (ref) => HomeProvider(),
);
