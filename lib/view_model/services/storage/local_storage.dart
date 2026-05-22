import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Thin wrapper over [FlutterSecureStorage] — tokens and light profile flags.
class LocalStorage {
  LocalStorage({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  static const _tokenKey = 'auth_token';
  static const _guestKey = 'is_guest';
  static const _profileNameKey = 'profile_name';

  final FlutterSecureStorage _storage;

  Future<void> init() async {}

  Future<void> writeToken(String token) =>
      _storage.write(key: _tokenKey, value: token);

  Future<String?> readToken() => _storage.read(key: _tokenKey);

  Future<void> writeProfileName(String name) =>
      _storage.write(key: _profileNameKey, value: name);

  Future<String?> readProfileName() => _storage.read(key: _profileNameKey);

  Future<bool> isGuestUser() async =>
      (await _storage.read(key: _guestKey)) == 'true';

  Future<void> setGuestSession() async {
    await _storage.delete(key: _profileNameKey);
    await _storage.write(key: _guestKey, value: 'true');
    await writeToken('guest');
  }

  Future<void> clearGuestFlag() async {
    await _storage.delete(key: _guestKey);
  }

  Future<void> clearSession() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _guestKey);
    await _storage.delete(key: _profileNameKey);
  }

  Future<void> clearAll() => _storage.deleteAll();
}
