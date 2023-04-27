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
            count: 0,
          ),
        );

  TagRepository tagRepository;

  Future<void> initialized(String? memberId) async {
    await getList(memberId ?? '');
    await setTag(state.tagList[0]);
  }

  Future<void> getList(String memberId) async {
    final tagList = await tagRepository.getList(memberId);

    tagList.sort((a, b) => a.position.compareTo(b.position));

    tagList.add(
      Tag(
        uuid: "",
        name: " + ",
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

  Future<void> refresh(String memberId, bool isSetTag, bool isDelete) async {
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

    if (isDelete) {
      await reorderTagListWithDelete(memberId);
    }

    if (state.tagList.length > 1 && isSetTag) {
      await setTag(state.tagList[state.tagList.length - 2]);
    } else {
      await setTag(state.tagList[0]);
    }
  }

  Future<void> reorderTagListWithEdit(
      int oldIndex, int newIndex, String memberId) async {
    final items = [...state.tagList];
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    items.insert(newIndex, items.removeAt(oldIndex));
    state = state.copyWith(tagList: items);

    for (int i = 0; i < state.tagList.length; i++) {
      final tag = Tag(
        uuid: state.tagList[i].uuid,
        name: state.tagList[i].name,
        position: i + 1,
        createdAt: state.tagList[i].createdAt,
        updatedAt: state.tagList[i].updatedAt,
      );
      if (state.tagList[i].uuid != "" && state.tagList[i].uuid != null) {
        await tagRepository.update(memberId, tag);
      }
    }
  }

  Future<void> reorderTagListWithDelete(String memberId) async {
    for (int i = 0; i < state.tagList.length; i++) {
      final tag = Tag(
        uuid: state.tagList[i].uuid,
        name: state.tagList[i].name,
        position: i + 1,
        createdAt: state.tagList[i].createdAt,
        updatedAt: state.tagList[i].updatedAt,
      );
      if (state.tagList[i].uuid != "" && state.tagList[i].uuid != null) {
        await tagRepository.update(memberId, tag);
      }
    }
  }

  Future<void> setCount() async {
    state = state.copyWith(count: state.count + 1);
  }
}

final tagController = StateNotifierProvider<TagController, TagState>(
  (ref) => TagController(tagRepository: ref.watch(tagRepositoryProvider)),
);
