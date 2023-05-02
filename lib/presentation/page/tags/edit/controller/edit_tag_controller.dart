import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/tag.dart';
import 'package:mylis/domain/repository/tag.dart';
import 'package:mylis/infrastructure/tag.dart';
import 'package:mylis/presentation/page/tags/edit/controller/edit_tag_state.dart';

class EditTagController extends StateNotifier<EditTagState> {
  EditTagController({
    required this.tagRepository,
  }) : super(
          EditTagState(
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

  void setName(String name) {
    final tag = Tag(
      uuid: state.tag.uuid,
      name: name,
      position: state.tag.position,
      createdAt: state.tag.createdAt,
      updatedAt: state.tag.updatedAt,
    );
    state = state.copyWith(tag: tag);
  }

  Future<void> update(String memberId) async {
    final tag = Tag(
      uuid: state.tag.uuid,
      name: state.tag.name,
      position: state.tag.position,
      createdAt: state.tag.createdAt,
      updatedAt: DateTime.now(),
    );
    await tagRepository.update(memberId, tag);
  }

  Future<void> delete(String memberId, String tagId) async {
    await tagRepository.delete(memberId, tagId);
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

final editTagController =
    StateNotifierProvider<EditTagController, EditTagState>(
  (ref) => EditTagController(tagRepository: ref.watch(tagRepositoryProvider)),
);
