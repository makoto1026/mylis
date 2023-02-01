// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_article_state.freezed.dart';

@freezed
class RegisterArticleState with _$RegisterArticleState {
  const factory RegisterArticleState({
    required String title,
    required String url,
    String? memo,
  }) = _RegisterArticleState;
  const RegisterArticleState._();
}
