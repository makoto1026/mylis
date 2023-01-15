import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mylis/presentation/page/main_page.dart';

part 'tab_state.freezed.dart';

@freezed
class TabState with _$TabState {
  const factory TabState({
    required Tab tab,
  }) = _TabState;
  const TabState._();
}
