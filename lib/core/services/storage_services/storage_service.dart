import 'package:dokkan/core/services/storage_services/secure_storage_service.dart';
import 'package:dokkan/core/services/storage_services/shared_prefrences_service.dart';
import 'package:flutter/material.dart';

abstract class StorageServiceBase {
  final SecureStorageService _secureStorageService;
  final SharedPrefsService _sharedPrefsService;
  StorageServiceBase(this._secureStorageService, this._sharedPrefsService);
}

class StorageService extends StorageServiceBase {
  StorageService(super._secureStorageService, super._sharedPrefsService);

  // Access Token
  Future<void> setAccessToken(String token) async =>
      await _secureStorageService.setAccessToken(token);
  Future<String?> getAccessToken() async =>
      await _secureStorageService.accessToken;
  Future<void> deleteAccessToken() async =>
      await _secureStorageService.deleteAccessToken();
  Future<bool> hasAccessToken() async {
    final t = await getAccessToken();
    return t != null && t.trim().isNotEmpty;
  }

  // Refresh Token
  Future<void> setRefreshToken(String token) async =>
      await _secureStorageService.setRefreshToken(token);
  Future<String?> getRefreshToken() async =>
      await _secureStorageService.refreshToken;
  Future<void> deleteRefreshToken() async =>
      await _secureStorageService.deleteRefreshToken();
  Future<bool> hasRefreshToken() async {
    final t = await getRefreshToken();
    return t != null && t.trim().isNotEmpty;
  }

  // Token Expiry Key & Methods (Persisted via SharedPrefs setMap)
  static const String tokenExpiryKey = 'expire-token';

  Future<void> saveTokenExpiry(String expiresAtUtc) async =>
      await setMap(tokenExpiryKey, {'expiresAtUtc': expiresAtUtc});

  Future<void> setTokenExpiryDate(DateTime expiryDate) async =>
      await saveTokenExpiry(expiryDate.toUtc().toIso8601String());

  String? getRawTokenExpiry() =>
      getMap(tokenExpiryKey)?['expiresAtUtc'] as String?;

  DateTime? getTokenExpiry() {
    final raw = getRawTokenExpiry();
    if (raw == null || raw.trim().isEmpty) return null;
    try {
      return DateTime.parse(raw.trim()).toUtc();
    } catch (_) {
      return null;
    }
  }

  bool get isTokenExpired {
    final expiry = getTokenExpiry();
    if (expiry == null) return false;
    return expiry.toUtc().isBefore(
      DateTime.now().toUtc().add(const Duration(seconds: 30)),
    );
  }

  Future<void> deleteTokenExpiry() async =>
      await deleteMap(tokenExpiryKey);

  // Save / Clear All Auth Tokens
  Future<void> saveAuthTokens({
    required String accessToken,
    required String refreshToken,
  }) async => await _secureStorageService.saveTokens(
    accessToken: accessToken,
    refreshToken: refreshToken,
  );
  Future<void> clearAuthTokens() async {
    await _secureStorageService.clearAuthTokens();
    await deleteTokenExpiry();
  }

  // Backward-compatible aliases
  Future<void> setToken(String token) async => await setAccessToken(token);
  Future<String?> getToken() async => await getAccessToken();
  Future<void> deleteToken() async => await deleteAccessToken();
  Future<bool> hasToken() async => await hasAccessToken();

  // User Data
  Future<void> setSecureMap(Map<String, dynamic> data) async =>
      await _secureStorageService.setSecureMap(data);
  Future<Map<String, dynamic>?> secureMap() async =>
      await _secureStorageService.secureMap;
  Future<void> deleteSecureMap() async =>
      await _secureStorageService.deleteSecureMap();

  // Language
  Future<void> setLanguage(Locale code) async =>
      await _sharedPrefsService.setLanguage(code);
  Locale? get language => _sharedPrefsService.language;

  // Theme Mode
  Future<void> setThemeMode(ThemeMode mode) async =>
      await _sharedPrefsService.setThemeMode(mode);
  ThemeMode get themeMode => _sharedPrefsService.themeMode;

  // Map
  Future<void> setMap(String key, Map<String, dynamic> data) async =>
      await _sharedPrefsService.setMap(key, data);
  Map<String, dynamic>? getMap(String key) => _sharedPrefsService.getMap(key);
  Future<void> deleteMap(String key) async =>
      await _sharedPrefsService.deleteMap(key);

  // Location
  Future<void> saveLocationData({
    required double latitude,
    required double longitude,
    required String address,
  }) async => await _sharedPrefsService.saveLocationData(
    latitude: latitude,
    longitude: longitude,
    address: address,
  );

  Future<({double? latitude, double? longitude, String? address})>
  getLocationData() async => await _sharedPrefsService.getLocationData();

  bool get isLocationSelected => _sharedPrefsService.isLocationSelected;
  int get locationDismissedCount => _sharedPrefsService.locationDismissedCount;
  Future<void> incrementLocationDismissedCount() async =>
      await _sharedPrefsService.incrementLocationDismissedCount();
  Future<void> resetLocationDismissedCount() async =>
      await _sharedPrefsService.resetLocationDismissedCount();

  Future<bool> get isUserRegistered async =>
      await _secureStorageService.isUserRegistered();

  Future<void> setSkippedOnBoarding() async =>
      await _sharedPrefsService.setSkippedOnBoarding();

  bool get isSkippedOnBoarding => _sharedPrefsService.isSkippedOnBoarding;

  Future<void> deleteSkippedOnBoarding() async =>
      await _sharedPrefsService.deleteSkippedOnBoarding();

  // Clear
  Future<void> clearAll() async => {
    await Future.wait({
      _secureStorageService.clearAll(),
      _sharedPrefsService.clearAll(),
    }),
  };
}
