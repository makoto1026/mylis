import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/tag.dart';
import 'package:mylis/domain/repository/tag.dart';
import 'package:mylis/infrastructure/tag.dart';
import 'package:mylis/presentation/page/tags/delete/delete_tag_state.dart';

class DeleteTagController extends StateNotifier<DeleteTagState> {
  DeleteTagController({
    required this.tagRepository,
  }) : super(
          DeleteTagState(
            uuid: "",
            tag: Tag(
              uuid: "",
              name: "選択してください",
              position: 0,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
            isLoading: false,
          ),
        );

  TagRepository tagRepository;

  Future<void> setTag(Tag tag) async {
    state = state.copyWith(tag: tag);
  }

  Future<void> delete() async {
    final tag = Tag(
      uuid: state.tag.uuid,
      name: state.tag.name,
      position: state.tag.position,
      createdAt: state.tag.createdAt,
      updatedAt: DateTime.now(),
    );
    await tagRepository.delete(tag.uuid ?? "");
  }

  Future<void> refresh() async {
    final tag = Tag(
      name: "",
      position: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    state = state.copyWith(
      uuid: "",
      tag: tag,
    );
  }

  Future<void> setIsLoading(bool isLoading) async {
    state = state.copyWith(isLoading: isLoading);
  }
}

final deleteTagController =
    StateNotifierProvider<DeleteTagController, DeleteTagState>(
  (ref) => DeleteTagController(tagRepository: ref.watch(tagRepositoryProvider)),
);
