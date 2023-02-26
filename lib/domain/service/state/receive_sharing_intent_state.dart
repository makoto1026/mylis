// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

part 'receive_sharing_intent_state.freezed.dart';

@freezed
class ReceiveSharingIntentState with _$ReceiveSharingIntentState {
  const factory ReceiveSharingIntentState({
    required String title,
    required String url,
    required List<SharedMediaFile> images,
  }) = _ReceiveSharingIntentState;
  const ReceiveSharingIntentState._();
}
