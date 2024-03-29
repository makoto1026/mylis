import 'package:yaml/yaml.dart';
import "package:flutter/services.dart";

class Config {
  Config._();
  static initialized() async {
    const env = String.fromEnvironment("ENV");
    final data = await rootBundle.loadString('env/$env.yaml');
    final doc = loadYaml(data) as YamlMap;
    _config = ConfigInfo(
      androidBannerID: doc["androidBannerID"],
      iosBannerID: doc["iosBannerID"],
    );
  }

  static ConfigInfo? _config;

  static ConfigInfo get app {
    if (_config == null) {
      throw "Not initialized config";
    }
    return _config!;
  }
}

class ConfigInfo {
  ConfigInfo({
    required this.androidBannerID,
    required this.iosBannerID,
  });
  final String androidBannerID;
  final String iosBannerID;
}
