abstract class SecureStorageService {
  Future<String?> read({required String key});
  Future<void> delete({required String key});
  Future<void> write({required String key, required String value});
}
