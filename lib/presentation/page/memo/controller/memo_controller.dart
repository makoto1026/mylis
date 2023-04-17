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

  Future<void> initialized(String memberId) async {
    await getList(memberId);
  }

  Future<void> getList(String memberId) async {
    final memoList = await memoRepository.getList(memberId);
    state = state.copyWith(memoList: memoList);
  }

  Future<void> refresh(String memberId) async {
    state = state.copyWith(memoList: []);
    final memoList = await memoRepository.getList(memberId);
    state = state.copyWith(memoList: memoList);
  }
}

final memoController = StateNotifierProvider<MemoController, MemoState>(
  (ref) => MemoController(memoRepository: ref.watch(memoRepositoryProvider)),
);
