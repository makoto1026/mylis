import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/memo.dart';
import 'package:mylis/domain/repository/memo.dart';
import 'package:mylis/infrastructure/memo.dart';
import 'package:mylis/presentation/page/memo/edit/controller/edit_memo_state.dart';

class EditMemoController extends StateNotifier<EditMemoState> {
  EditMemoController({
    required this.memoRepository,
  }) : super(
          EditMemoState(
            title: '',
            body: '',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            deletedAt: null,
          ),
        );

  MemoRepository memoRepository;

  Future<void> setMemo(Memo memo) async {
    state = state.copyWith(
      title: memo.title,
      body: memo.body,
      createdAt: memo.createdAt,
      updatedAt: memo.updatedAt,
      deletedAt: memo.deletedAt,
    );
  }

  Future<void> setUpdateValue({
    String? title,
    String? body,
  }) async {
    state = state.copyWith(
      title: title ?? state.title,
      body: body ?? state.body,
    );
  }

  Future<void> update() async {
    final memo = Memo(
      title: state.title,
      body: state.body,
      createdAt: state.createdAt,
      updatedAt: DateTime.now(),
      deletedAt: state.deletedAt ?? DateTime.now(),
    );
    await memoRepository.update(memo);
  }

  //TODO: refreshは必要なのか？ref.refresh()でいける？
  Future<void> refresh() async {
    state = state.copyWith(
      title: "",
      body: "",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      deletedAt: DateTime.now(),
    );
  }
}

final editMemoController =
    StateNotifierProvider<EditMemoController, EditMemoState>(
  (ref) => EditMemoController(
    memoRepository: ref.watch(memoRepositoryProvider),
  ),
);
