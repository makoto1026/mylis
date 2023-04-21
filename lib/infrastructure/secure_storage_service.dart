import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/service/secure_storage_service.dart';

class ISecureStorageService extends SecureStorageService {
  ISecureStorageService();
  final storage = const FlutterSecureStorage();

  @override
  Future<String?> read({required String key}) {
    return storage.read(key: key);
  }

  @override
  Future<void> delete({required String key}) {
    return storage.delete(key: key);
  }

  @override
  Future<void> write({required String key, required String value}) {
    return storage.write(key: key, value: value);
  }

  @override
  Future<void> saveShareData({required String key, required String value}) {
    return storage.write(key: key, value: value);
  }
}

final secureStorageServiceProvider =
    Provider<ISecureStorageService>((ref) => ISecureStorageService());
