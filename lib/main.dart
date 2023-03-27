import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/config.dart';
import 'package:mylis/domain/service/receive_sharing_intent_service.dart';
import 'package:mylis/presentation/page/articles/article/controller/article_controller.dart';
import 'package:mylis/provider/current_user_provider.dart';
import 'package:mylis/provider/loading_state_provider.dart';
import 'package:mylis/provider/session_provider.dart';
import 'package:mylis/provider/tab/current_tab_provider.dart';
import 'package:mylis/router/router.dart';
import 'package:mylis/theme/default.dart';

import 'firebase_options.dart';
import 'presentation/page/tags/tag/controller/tag_controller.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Config.initialized();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

final navKeyProvider = Provider((ref) => GlobalKey<NavigatorState>());

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      () async {
        await Future.wait({
          ref.read(sessionProvider.notifier).checkSignInState(),
          ref.read(receiveSharingIntentProvider.notifier).initialized(),
          // ref.read(userController.notifier).initialized(),
          ref.read(tagController.notifier).initialized(),
          ref.read(currentTabProvider.notifier).initialized()
        });
        final tagState = ref.watch(tagController);
        await ref
            .watch(articleController.notifier)
            .initialized(tagState.tagList);
        await Future.delayed(const Duration(seconds: 3));
        FlutterNativeSplash.remove();
      }();
      return () {};
    }, []);

    return MaterialApp(
      routes: ref.read(routerProvider),
      initialRoute: ref.watch(currentUserProvider) == null
          ? RouteNames.auth.path
          : RouteNames.main.path,
      title: 'mylis',
      theme: ref.read(
        themeProvider(context),
      ),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
        child: GestureDetector(
          onTap: () {
            final FocusScopeNode currentScope = FocusScope.of(context);
            if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              child!,
              if (ref.watch(loadingStateProvider))
                Container(
                  color: Colors.transparent,
                  width: double.infinity,
                  height: double.infinity,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        ),
      ),
      navigatorKey: ref.read(navKeyProvider),
    );
  }
}
