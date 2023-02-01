import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/repository/memo.dart';
import 'package:mylis/infrastructure/memo.dart';
import 'package:mylis/presentation/page/memo/controller/memo_state.dart';

class MemoController extends StateNotifier<MemoState> {
  MemoController({required this.memoRepository})
      : super(
          const MemoState(
            memoList: [],
          ),
        );

  MemoRepository memoRepository;

  Future<void> initialized() async {
    await getList();
  }

  Future<void> getList() async {
    final memoList = await memoRepository.getList("");
    state = state.copyWith(memoList: memoList);
  }
}

final memoController = StateNotifierProvider<MemoController, MemoState>(
  (ref) => MemoController(memoRepository: ref.watch(memoRepositoryProvider)),
);
