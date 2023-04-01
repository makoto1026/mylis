import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/memo.dart';
import 'package:mylis/domain/repository/memo.dart';
import 'package:mylis/infrastructure/memo.dart';
import 'package:mylis/presentation/page/memo/delete/controller/delete_memo_state.dart';

class DeleteMemoController extends StateNotifier<DeleteMemoState> {
  DeleteMemoController({
    required this.memoRepository,
  }) : super(
          DeleteMemoState(
            title: '',
            body: '',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            deletedAt: null,
          ),
        );

  MemoRepository memoRepository;

  void setMemo({String? title, String? body}) {
    state = state.copyWith(
      title: title ?? state.title,
      body: body ?? state.body,
    );
  }

  Future<void> delete() async {
    final memo = Memo(
      title: state.title,
      body: state.body,
      createdAt: state.createdAt,
      updatedAt: state.updatedAt,
      deletedAt: state.deletedAt ?? DateTime.now(),
    );
    await memoRepository.delete(memo);
  }

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

final registerMemoController =
    StateNotifierProvider<DeleteMemoController, DeleteMemoState>(
  (ref) => DeleteMemoController(
    memoRepository: ref.watch(memoRepositoryProvider),
  ),
);
