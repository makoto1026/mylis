import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/repository/tag.dart';
import 'package:mylis/infrastructure/tag.dart';
import 'package:mylis/provider/tag/tag_state.dart';

class TagController extends StateNotifier<TagState> {
  TagController({
    required this.tagRepository,
  }) : super(
          const TagState(
            tagList: [],
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
}

final tagController = StateNotifierProvider<TagController, TagState>(
  (ref) => TagController(tagRepository: ref.watch(tagRepositoryProvider)),
);
