import 'package:mylis/domain/entities/app_config.dart';

abstract class AdminRepository {
  Future<AppConfig> getAppConfig();
}
