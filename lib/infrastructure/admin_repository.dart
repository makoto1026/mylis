import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/app_config.dart';
import 'package:mylis/domain/repository/admin_repository.dart';
import 'package:mylis/infrastructure/firestore/firestore.dart';
import 'package:mylis/infrastructure/mapper/app_config_mapper.dart';

class IAdminRepository extends AdminRepository {
  final configDB = Firestore.config;

  @override
  Future<AppConfig> getAppConfig() async {
    return await configDB.get().then(
      (value) {
        final doc = value.data();
        return AppConfigMapper.fromJSON(doc!);
      },
    );
  }
}

final adminRepositoryProvider =
    Provider<IAdminRepository>((ref) => IAdminRepository());
