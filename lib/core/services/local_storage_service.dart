/// Local storage service
/// SharedPreferences yoki hech qanday package-siz simple implementation
/// Production uchun shared_preferences qo'shish kerak

import 'dart:convert';

// Simple in-memory storage (production-da SharedPreferences ishlating)
class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();

  final Map<String, dynamic> _storage = {};

  factory LocalStorageService() {
    return _instance;
  }

  LocalStorageService._internal();

  // String saqlash
  Future<void> saveString(String key, String value) async {
    _storage[key] = value;
  }

  // String o'qish
  String? getString(String key) {
    return _storage[key] as String?;
  }

  // Bool saqlash
  Future<void> saveBool(String key, bool value) async {
    _storage[key] = value;
  }

  // Bool o'qish
  bool? getBool(String key) {
    return _storage[key] as bool?;
  }

  // Int saqlash
  Future<void> saveInt(String key, int value) async {
    _storage[key] = value;
  }

  // Int o'qish
  int? getInt(String key) {
    return _storage[key] as int?;
  }

  // JSON saqlash
  Future<void> saveJson(String key, Map<String, dynamic> value) async {
    _storage[key] = jsonEncode(value);
  }

  // JSON o'qish
  Map<String, dynamic>? getJson(String key) {
    final value = _storage[key];
    if (value == null) return null;
    return jsonDecode(value) as Map<String, dynamic>;
  }

  // Barcha ma'lumotlarni o'chirish
  Future<void> clear() async {
    _storage.clear();
  }

  // Specific key o'chirish
  Future<void> remove(String key) async {
    _storage.remove(key);
  }

  // Key mavjudmi?
  bool hasKey(String key) {
    return _storage.containsKey(key);
  }
}
