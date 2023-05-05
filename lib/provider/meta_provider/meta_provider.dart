import 'dart:async';

import 'package:mylis/domain/repository/admin_repository.dart';
import 'package:mylis/infrastructure/admin_repository.dart';
import 'package:mylis/provider/meta_provider/meta.dart';
import 'package:package_info_plus/package_info_plus.dart';
// ignore: depend_on_referenced_packages
import 'package:riverpod/riverpod.dart';

class MetaProvider extends StateNotifier<Meta> {
  MetaProvider({
    required this.adminRepository,
  }) : super(
          Meta(
            appVersion: "1.0.2",
            isForceUpdate: false,
            appUrl: "",
          ),
        );

  final AdminRepository adminRepository;

  Future<bool> getIsForceUpdate() async {
    final packageInfo = await PackageInfo.fromPlatform();
    state = state.copyWith(appVersion: packageInfo.version);

    final appConfig = await adminRepository.getAppConfig();

    int version(String version) {
      return int.parse(version.replaceAll(RegExp(r'\.'), ""));
    }

    state = state.copyWith(
        isForceUpdate: version(state.appVersion) <
            version(appConfig.forceUpdateAndroidVersion));

    return state.isForceUpdate;
  }
}

final metaProvider = StateNotifierProvider<MetaProvider, Meta>(
  (ref) => MetaProvider(adminRepository: ref.read(adminRepositoryProvider)),
);
