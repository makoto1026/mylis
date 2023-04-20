import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/service/state/receive_sharing_intent_state.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

class ReceiveSharingIntentProvider
    extends StateNotifier<ReceiveSharingIntentState> {
  ReceiveSharingIntentProvider()
      : super(
          const ReceiveSharingIntentState(
            images: [],
            title: '',
            url: '',
          ),
        );

  late StreamSubscription _intentDataStreamSubscription;

  Future<void> initialized() async {
    state = state.copyWith(images: [], title: "", url: "");
    _intentDataStreamSubscription =
        ReceiveSharingIntent.getMediaStream().listen(
      (event) {
        state = state.copyWith(images: event);
      },
    );

    ReceiveSharingIntent.getInitialMedia().then(
      (event) {
        state = state.copyWith(images: event);
      },
    );

    _intentDataStreamSubscription = ReceiveSharingIntent.getTextStream().listen(
      (event) {
        state = state.copyWith(url: event);
      },
    );

    ReceiveSharingIntent.getInitialText().then(
      (event) {
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
  (ref) => ReceiveSharingIntentProvider(),
);
