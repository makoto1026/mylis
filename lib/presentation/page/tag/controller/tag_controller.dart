import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/tag.dart';
import 'package:mylis/domain/repository/tag.dart';
import 'package:mylis/infrastructure/tag.dart';
import 'package:mylis/presentation/page/tag/controller/tag_state.dart';
import 'package:yaml/yaml.dart';

class TagController extends StateNotifier<TagState> {
  TagController({
    required this.tagRepository,
  }) : super(
          TagState(
            tagList: [],
            name: "",
            position: 0,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );

  TagRepository tagRepository;

  Future<void> initialized() async {
    await getList();
  }

  Future<void> getList() async {
    final tagList = await tagRepository.getList("");
    state = state.copyWith(tagList: tagList);
  }

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  Future<void> create() async {
    final tag = Tag(
      name: state.name,
      position: state.tagList.length + 1,
      createdAt: state.createdAt,
      updatedAt: state.updatedAt,
    );
    await tagRepository.create(tag);
  }

  Future<void> refresh() async {
    state = state.copyWith(name: "");
    getList();
  }
}

final tagController = StateNotifierProvider<TagController, TagState>(
  (ref) => TagController(tagRepository: ref.watch(tagRepositoryProvider)),
);
