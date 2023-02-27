import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/service/state/receive_sharing_intent_state.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

class ReceiveSharingIntentProvider
    extends StateNotifier<ReceiveSharingIntentState> {
  ReceiveSharingIntentProvider({
    required Reader read,
  })  : _read = read,
        super(
          const ReceiveSharingIntentState(
            images: [],
            title: '',
            url: '',
          ),
        );

  final Reader _read;
  late StreamSubscription _intentDataStreamSubscription;

  Future<void> initialized() async {
    state = state.copyWith(images: [], title: "", url: "");
    _intentDataStreamSubscription =
        ReceiveSharingIntent.getMediaStream().listen(
      (event) {
        print("-------getMediaStream = $event-------");
        // NavigationService.navigatorKey.currentState?.pushNamed(
        //   RouteNames.registerArticle.path,
        //   arguments: event,
        // );
        state = state.copyWith(images: event);
      },
    );

    ReceiveSharingIntent.getInitialMedia().then(
      (event) {
        print("-------getInitialMedia = $event-------");
        // NavigationService.navigatorKey.currentState?.pushNamed(
        //   RouteNames.registerArticle.path,
        //   arguments: event,
        // );
        state = state.copyWith(images: event);
      },
    );

    _intentDataStreamSubscription = ReceiveSharingIntent.getTextStream().listen(
      (event) {
        print("-------getTextStream = $event-------");
        // NavigationService.navigatorKey.currentState?.pushNamed(
        //   RouteNames.registerArticle.path,
        //   arguments: event,
        // );
        state = state.copyWith(url: event);
      },
    );

    ReceiveSharingIntent.getInitialText().then(
      (event) {
        print("-------getInitialText = $event-------");
        state = state.copyWith(url: event ?? "");
      },
    );
  }

  @override
  void dispose() {
    _intentDataStreamSubscription.cancel();
    super.dispose();
  }
}

final receiveSharingIntentProvider = StateNotifierProvider<
    ReceiveSharingIntentProvider, ReceiveSharingIntentState>(
  (ref) => ReceiveSharingIntentProvider(
    read: ref.read,
  ),
);
