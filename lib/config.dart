import 'package:yaml/yaml.dart';
import "package:flutter/services.dart";

class Config {
  Config._();
  static initialized() async {
    const env = String.fromEnvironment("ENV");
    final data = await rootBundle.loadString('env/$env.yaml');
    final doc = loadYaml(data) as YamlMap;
    _config = ConfigInfo(
      androidBannerAdID: doc["androidBannerAdID"],
      iosBannerAdID: doc["iosBannerAdID"],
      androidInterStitialAdID: doc["androidInterStitialAdID"],
      iosInterStitialAdID: doc["iosInterStitialAdID"],
      androidRewardAdID: doc["androidRewardAdID"],
      iosRewardAdID: doc["iosRewardAdID"],
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
    required this.androidBannerAdID,
    required this.iosBannerAdID,
    required this.androidInterStitialAdID,
    required this.iosInterStitialAdID,
    required this.androidRewardAdID,
    required this.iosRewardAdID,
  });
  final String androidBannerAdID;
  final String iosBannerAdID;
  final String androidInterStitialAdID;
  final String iosInterStitialAdID;
  final String androidRewardAdID;
  final String iosRewardAdID;
}
