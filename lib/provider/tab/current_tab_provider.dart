import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/main_page.dart';
import 'package:mylis/provider/tab/tab_state.dart';

class CurrentTabProvider extends StateNotifier<TabState> {
  CurrentTabProvider()
      : super(
          const TabState(
            tab: Tab.home,
          ),
        );

  Future<void> initialized() async {
    state = state.copyWith(tab: Tab.home);
  }

  void changeTab(Tab tab) {
    if (tab == state.tab) {
      return;
    }

    state = state.copyWith(tab: tab);
  }
}

final currentTabProvider =
    StateNotifierProvider.autoDispose<CurrentTabProvider, TabState>(
        (ref) => CurrentTabProvider());
