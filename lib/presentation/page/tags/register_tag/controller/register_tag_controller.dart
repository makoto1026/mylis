import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/tag.dart';
import 'package:mylis/domain/repository/tag.dart';
import 'package:mylis/infrastructure/tag.dart';
import 'package:mylis/presentation/page/tags/register_tag/controller/register_tag_state.dart';

class RegisterTagController extends StateNotifier<RegisterTagState> {
  RegisterTagController({
    required this.tagRepository,
  }) : super(
          RegisterTagState(
            name: "",
            position: 0,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            isLoading: false,
          ),
        );

  TagRepository tagRepository;

  Future<void> initialized() async {}

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  Future<void> create({String? tagName}) async {
    final isRegisterArticle = tagName != null && tagName != "";

    final tag = Tag(
      uuid: "",
      name: isRegisterArticle ? tagName : state.name,
      position: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await tagRepository.create(tag);
  }

  Future<void> refresh() async {
    state = state.copyWith(
      name: "",
      position: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  Future<void> setIsLoading(bool isLoading) async {
    state = state.copyWith(isLoading: isLoading);
  }
}

final registerTagController =
    StateNotifierProvider<RegisterTagController, RegisterTagState>(
  (ref) =>
      RegisterTagController(tagRepository: ref.watch(tagRepositoryProvider)),
);
