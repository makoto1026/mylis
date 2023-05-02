import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/memo.dart';
import 'package:mylis/domain/repository/memo.dart';
import 'package:mylis/infrastructure/memo.dart';
import 'package:mylis/presentation/page/memo/register/controller/register_memo_state.dart';

class RegisterMemoController extends StateNotifier<RegisterMemoState> {
  RegisterMemoController({
    required this.memoRepository,
  }) : super(
          RegisterMemoState(
            title: '',
            body: '',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            deletedAt: null,
          ),
        );

  MemoRepository memoRepository;

  void setNewMemo({String? title, String? body}) {
    state =
        state.copyWith(title: title ?? state.title, body: body ?? state.body);
  }

  Future<void> create(String memberId) async {
    final memo = Memo(
      title: state.title,
      body: state.body,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await memoRepository.create(memberId, memo);
  }
}

final registerMemoController =
    StateNotifierProvider<RegisterMemoController, RegisterMemoState>(
  (ref) => RegisterMemoController(
    memoRepository: ref.watch(memoRepositoryProvider),
  ),
);
