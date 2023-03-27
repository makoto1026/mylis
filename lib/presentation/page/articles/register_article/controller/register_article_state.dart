// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mylis/domain/entities/tag.dart';

part 'register_article_state.freezed.dart';

@freezed
class RegisterArticleState with _$RegisterArticleState {
  const factory RegisterArticleState({
    required String title,
    required String url,
    String? memo,
    Tag? tag,
    required int setCount,
  }) = _RegisterArticleState;
  const RegisterArticleState._();
}
