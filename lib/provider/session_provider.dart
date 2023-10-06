import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/service/secure_storage_service.dart';
import 'package:mylis/infrastructure/secure_storage_service.dart';
import 'package:mylis/main.dart';
import 'package:mylis/presentation/page/auth/auth_page.dart';
import 'package:mylis/presentation/page/main_page.dart';
import 'package:mylis/presentation/page/walk_through.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/provider/loading_state_provider.dart';
import 'package:mylis/snippets/show_auth_error_dialog.dart';
import 'package:page_transition/page_transition.dart';

class SessionProvider extends StateNotifier<void> {
  SessionProvider({
    required SecureStorageService secureStorageService,
    required Reader read,
  })  : _secureStorageService = secureStorageService,
        _read = read,
        super(null);
  final SecureStorageService _secureStorageService;
  final Reader _read;

  Future<void> signIn(String? uuid) async {
    await Future.wait([
      _secureStorageService.write(
        key: 'is_signed_in',
        value: 'true',
      ),
      _secureStorageService.write(
        key: 'member_id',
        value: uuid!,
      ),
      _read(currentMemberProvider.notifier).set(uuid).whenComplete(
            () => checkSignInState(),
          ),
    ]);
  }

  Future<void> checkSignInState() async {
    final isFirstOpen =
        await _secureStorageService.read(key: "isFirstOpen") ?? "true";

    final isSignedIn = await _secureStorageService.read(key: 'is_signed_in');
    final memberId = await _secureStorageService.read(key: 'member_id');

    await _read(loadingStateProvider.notifier).stopLoading();

    if (isSignedIn == null) {
      return;
    }

    await _read(currentMemberProvider.notifier).set(memberId);

    final currentMember = _read(currentMemberProvider);

    if (currentMember?.deletedAt != null) {
      await showAuthErrorDialog(
        _read,
        "退会済みのアカウントです。\n\n別の認証方法で新規登録を行うか、アカウントの復旧をご希望の場合は運営までお問い合わせください。",
      );
      return;
    }

    if (currentMember?.uuid == "" || currentMember?.uuid == null) {
      Navigator.pushAndRemoveUntil(
        _read(navKeyProvider).currentContext!,
        PageTransition(
          type: PageTransitionType.fade,
          child: const AuthPage(),
        ),
        (route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        _read(navKeyProvider).currentContext!,
        PageTransition(
          type: PageTransitionType.fade,
          child: isFirstOpen == "true"
              ? const WalkThroughPage()
              : const MainPage(),
        ),
        (route) => false,
      );
    }
  }

  Future<void> signOut() async {
    await Future.wait([
      _secureStorageService.delete(key: 'is_signed_in'),
      _secureStorageService.delete(key: 'member_id'),
    ]);
    _read(currentMemberProvider.notifier).signOut();
  }
}

final sessionProvider = StateNotifierProvider<SessionProvider, void>(
  (ref) => SessionProvider(
    secureStorageService: ref.watch(
      secureStorageServiceProvider,
    ),
    read: ref.read,
  ),
);
