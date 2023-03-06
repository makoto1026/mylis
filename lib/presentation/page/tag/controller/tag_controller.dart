import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/tag.dart';
import 'package:mylis/domain/repository/tag.dart';
import 'package:mylis/infrastructure/tag.dart';
import 'package:mylis/presentation/page/tag/controller/tag_state.dart';

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

  Future<void> initialized() async {
    await getList();
    await setTag(state.tagList[0]);
  }

  Future<void> getList() async {
    final tagList = await tagRepository.getList("");
    state = state.copyWith(tagList: tagList);
  }

  void setName(String name) {
    final tag = Tag(
      name: name,
      position: state.tag.position,
      createdAt: state.tag.createdAt,
      updatedAt: state.tag.updatedAt,
    );
    state = state.copyWith(tag: tag);
  }

  Future<void> setTag(Tag tag) async {
    state = state.copyWith(tag: tag);
  }

  Future<void> create() async {
    final tag = Tag(
      uuid: "",
      name: state.tag.name,
      position: state.tagList.length + 1,
      createdAt: state.tag.createdAt,
      updatedAt: state.tag.updatedAt,
    );
    await tagRepository.create(tag);
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
    getList();
  }
}

final tagController = StateNotifierProvider<TagController, TagState>(
  (ref) => TagController(tagRepository: ref.watch(tagRepositoryProvider)),
);
