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
            isLoading: false,
          ),
        );

  TagRepository tagRepository;

  Future<void> initialized() async {
    await getList();
    await setTag(state.tagList[0]);
  }

  Future<void> getList() async {
    final tagList = await tagRepository.getList("");
    tagList.add(
      Tag(
        name: "タグ +",
        position: tagList.length + 1,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
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

  void setNameWithEditTag(String name) {
    final tag = Tag(
      uuid: state.tag.uuid,
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

  Future<void> setTagWithEditTag(Tag tag) async {
    state = state.copyWith(tag: tag);
  }

  Future<void> create({String? tagName}) async {
    final isRegisterArticle = tagName != null && tagName != "";

    final tag = Tag(
      uuid: "",
      name: isRegisterArticle ? tagName : state.tag.name,
      position: state.tagList.length + 1,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await tagRepository.create(tag);
  }

  // TODO: 編集は別のコントローラで管理した方がいいかも
  Future<void> update() async {
    final tag = Tag(
      uuid: state.tag.uuid,
      name: state.tag.name,
      position: state.tag.position,
      createdAt: state.tag.createdAt,
      updatedAt: DateTime.now(),
    );
    await tagRepository.update(tag);
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
    await getList();
    await setTag(state.tagList[0]);
  }

  Future<void> setIsLoading(bool isLoading) async {
    state = state.copyWith(isLoading: isLoading);
  }
}

final tagController = StateNotifierProvider<TagController, TagState>(
  (ref) => TagController(tagRepository: ref.watch(tagRepositoryProvider)),
);
