import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/service/secure_storage_service.dart';
import 'package:mylis/infrastructure/secure_storage_service.dart';
import 'package:mylis/main.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/router/router.dart';

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
    final isSignedIn = await _secureStorageService.read(key: 'is_signed_in');
    final memberId = await _secureStorageService.read(key: 'member_id');

    if (isSignedIn == null) {
      return;
    }

    await _read(currentMemberProvider.notifier).set(memberId);

    final currentUser = _read(currentMemberProvider);

    if (currentUser?.uuid == "" || currentUser?.uuid == null) {
      Navigator.of(_read(navKeyProvider).currentContext!, rootNavigator: true)
          .pushNamedAndRemoveUntil(
        RouteNames.auth.path,
        (_) => false,
      );
    } else {
      Navigator.of(_read(navKeyProvider).currentContext!, rootNavigator: true)
          .pushNamedAndRemoveUntil(
        RouteNames.main.path,
        (_) => false,
      );
    }
  }

  Future<void> signOut() async {
    await Future.wait([_secureStorageService.delete(key: 'is_signed_in')]);
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
