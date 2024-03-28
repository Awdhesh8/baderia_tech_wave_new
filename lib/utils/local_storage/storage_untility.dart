


import 'package:get_storage/get_storage.dart';

class ELocalStorage {
  static final ELocalStorage _instance = ELocalStorage._internal();

  factory ELocalStorage() {
    return _instance;
  }

  ELocalStorage._internal();

  final _storage = GetStorage();

  // Generic method to save data
  Future<void> saveData<E>(String key, E value) async {
    await _storage.write(key, value);
  }

  // Generic method to read data
  E? readData<E>(String key) {
    return _storage.read<E>(key);
  }

  // Generic method to remove data
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  // Clear all data in Storage
  Future<void> clearAll() async {
    await _storage.erase();
  }


}