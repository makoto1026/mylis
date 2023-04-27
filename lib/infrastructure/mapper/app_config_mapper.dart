import 'package:mylis/domain/entities/app_config.dart';

class AppConfigMapper {
  static AppConfig fromJSON(Map<String, dynamic> json) {
    return AppConfig(
      forceUpdateAndroidVersion: json["force_update_version"] as String,
    );
  }
}
