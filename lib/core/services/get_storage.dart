import 'package:get_storage/get_storage.dart';

class GSService {
  static final box = GetStorage();

  static Future<void> init() async {
    await GetStorage.init();
  }

  static dynamic get(String key) {
    return box.read(key);
  }

  static Future<void> save(String key, dynamic value) async {
    await box.write(key, value);
  }

  static Future<void> remove(String key) async {
    await box.remove(key);
  }
}