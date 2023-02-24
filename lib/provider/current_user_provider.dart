import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/user.dart';

class CurrentUserProvider extends StateNotifier<User?> {
  CurrentUserProvider({required Reader read}) : super(null);

  Future<void> set() async {
    try {
      state = User(
        email: "trsmmkt@gmail.com",
        createdAt: DateTime.now(),
        fcmToken: '',
        lineUuid: '',
        name: '',
        phoneNumber: '',
        sex: 1,
        updatedAt: DateTime.now(),
      );
    } catch (e) {
      return;
    }
  }

  void signOut() {
    state = null;
  }
}

final currentUserProvider =
    StateNotifierProvider.autoDispose<CurrentUserProvider, User?>(
  (ref) => CurrentUserProvider(
    read: ref.read,
  ),
);

final isSignedInProvider =
    Provider.autoDispose((ref) => ref.watch(currentUserProvider) != null);
