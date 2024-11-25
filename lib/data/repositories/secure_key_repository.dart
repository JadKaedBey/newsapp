// Not used for now, implemented for the scope of not exposing the apiKey

import '../../core/constants/secure_storage_service.dart';

class SecureKeyRepository {
  final SecureStorageService _secureStorageService;

  SecureKeyRepository(this._secureStorageService);

  Future<void> saveApiKey(String apiKey) async {
    await _secureStorageService.saveKey('api_key', apiKey);
  }

  Future<String?> getApiKey() async {
    return await _secureStorageService.getKey('api_key');
  }

  Future<void> deleteApiKey() async {
    await _secureStorageService.deleteKey('api_key');
  }
}
