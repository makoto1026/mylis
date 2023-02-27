import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/service/secure_storage_service.dart';
import 'package:mylis/infrastructure/secure_storage_service.dart';
import 'package:mylis/main.dart';
import 'package:mylis/provider/current_user_provider.dart';
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

  Future<void> signIn() async {
    await Future.wait([
      _secureStorageService.write(
        key: "is_signed_in",
        value: "true",
      ),
    ]);
    final isSignedIn = await _secureStorageService.read(key: "is_signed_in");

    checkSignInState();
  }

  Future<void> checkSignInState() async {
    final isSignedIn = await _secureStorageService.read(key: "is_signed_in");

    if (isSignedIn == null) {
      return;
    }

    await _read(currentUserProvider.notifier).set();

    final currentUser = _read(currentUserProvider);

    if (currentUser == null) {
      return;
    }

    if (currentUser.name != "") {
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
    await Future.wait([_secureStorageService.delete(key: "is_signed_in")]);
    _read(currentUserProvider.notifier).signOut();
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
