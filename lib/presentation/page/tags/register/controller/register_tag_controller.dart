import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/tag.dart';
import 'package:mylis/domain/repository/tag.dart';
import 'package:mylis/infrastructure/tag.dart';
import 'package:mylis/presentation/page/tags/register/controller/register_tag_state.dart';

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

  Future<String> create(String memberId, int tagListLength) async {
    final tag = Tag(
      uuid: "",
      name: state.name,
      position: tagListLength + 1,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    return await tagRepository.create(memberId, tag);
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
