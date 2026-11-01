import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorageServiceBase {
  final FlutterSecureStorage _storage;
  static const _accessTokenKey = 'access-token';
  static const _refreshTokenKey = 'refresh-token';
  static const _mapDataKey = 'user-data';
  String? _cachedAccessToken;
  String? _cachedRefreshToken;

  SecureStorageServiceBase(this._storage);

  /// [setAccessToken] saving access token using [flutter_secure_storage] library
  /// use [accessToken] getter to get the token or null if there is no token saved
  /// use [deleteAccessToken] to delete saved access token
  Future<void> setAccessToken(String token) async => {
    await _storage.write(key: _accessTokenKey, value: token),
    _cachedAccessToken = token,
  };

  /// get saved access token (cache-aside: first call hits storage, then in-memory)
  Future<String?> get accessToken async =>
      _cachedAccessToken ??= await _storage.read(key: _accessTokenKey);

  /// delete saved access token
  Future<void> deleteAccessToken() async => {
    await _storage.delete(key: _accessTokenKey),
    _cachedAccessToken = null,
  };

  /// [setRefreshToken] saving refresh token using [flutter_secure_storage] library
  Future<void> setRefreshToken(String token) async => {
    await _storage.write(key: _refreshTokenKey, value: token),
    _cachedRefreshToken = token,
  };

  /// get saved refresh token
  Future<String?> get refreshToken async =>
      _cachedRefreshToken ??= await _storage.read(key: _refreshTokenKey);

  /// delete saved refresh token
  Future<void> deleteRefreshToken() async => {
    await _storage.delete(key: _refreshTokenKey),
    _cachedRefreshToken = null,
  };

  /// Backwards-compatible aliases
  Future<void> setToken(String token) async => await setAccessToken(token);
  Future<String?> get token async => await accessToken;
  Future<void> deleteToken() async => await deleteAccessToken();

  /// Save both tokens in one call
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async => {
    await setAccessToken(accessToken),
    await setRefreshToken(refreshToken),
  };

  /// Clear all authentication tokens
  Future<void> clearAuthTokens() async => {
    await deleteAccessToken(),
    await deleteRefreshToken(),
  };

  /// check if there is token or not
  Future<bool> isUserRegistered() async =>
      (await _storage.read(key: _accessTokenKey)) != null;

  // User Data
  Future<void> setSecureMap(Map<String, dynamic> data) async =>
      await _storage.write(key: _mapDataKey, value: jsonEncode(data));
  Future<Map<String, dynamic>?> get secureMap async {
    final data = await _storage.read(key: _mapDataKey);
    return data != null ? jsonDecode(data) : null;
  }

  Future<void> deleteSecureMap() async =>
      await _storage.delete(key: _mapDataKey);

  /// delete all saved data from secure storage
  Future<void> clearAll() async => {
    _cachedAccessToken = null,
    _cachedRefreshToken = null,
    await _storage.deleteAll(),
  };
}

class SecureStorageService extends SecureStorageServiceBase {
  SecureStorageService([FlutterSecureStorage? storage])
    : super(
        storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(
                // encryptedSharedPreferences: true
              ),
              iOptions: IOSOptions(
                accessibility: KeychainAccessibility.first_unlock_this_device,
              ),
            ),
      );
}
