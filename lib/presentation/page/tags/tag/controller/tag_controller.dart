import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/tag.dart';
import 'package:mylis/domain/repository/tag.dart';
import 'package:mylis/infrastructure/tag.dart';
import 'package:mylis/presentation/page/tags/tag/controller/tag_state.dart';

class TagController extends StateNotifier<TagState> {
  TagController({
    required this.tagRepository,
  }) : super(
          TagState(
            tagList: [],
            uuid: "",
            tag: Tag(
              uuid: "",
              name: "選択してください",
              position: 0,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          ),
        );

  TagRepository tagRepository;

  Future<void> initialized(String? memberId) async {
    await getList(memberId ?? '');
    await setTag(state.tagList[0]);
  }

  Future<void> getList(String memberId) async {
    final tagList = await tagRepository.getList(memberId);

    tagList.add(
      Tag(
        uuid: "",
        name: "タグ +",
        position: tagList.length + 1,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
    state = state.copyWith(tagList: tagList);
  }

  Future<void> setTag(Tag tag) async {
    state = state.copyWith(tag: tag);
  }

  Future<void> refresh(String memberId) async {
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
    await getList(memberId);
    if (state.tagList.length > 1) {
      await setTag(state.tagList[state.tagList.length - 2]);
    } else {
      await setTag(state.tagList[0]);
    }
  }
}

final tagController = StateNotifierProvider<TagController, TagState>(
  (ref) => TagController(tagRepository: ref.watch(tagRepositoryProvider)),
);
