import 'package:yaml/yaml.dart';
import "package:flutter/services.dart";

class Config {
  Config._();
  static initialized() async {
    const env = String.fromEnvironment("ENV");
    final data = await rootBundle.loadString('env/$env.yaml');
    final doc = loadYaml(data) as YamlMap;
    _config = ConfigInfo(test: doc["test"]);
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
    required this.test,
  });
  final String test;
}
