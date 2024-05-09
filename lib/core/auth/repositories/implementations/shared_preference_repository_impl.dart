import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_akhir_project/core/auth/repositories/sources/storage_repository.dart';

final sharedPreferenceRepositoryProvider =
    Provider<SharedPreferenceRepositoryImpl>((ref) {
  return SharedPreferenceRepositoryImpl();
});

class SharedPreferenceRepositoryImpl implements StorageRepository {
  @override
  Future<SharedPreferences> getInstance() async {
    return await SharedPreferences.getInstance();
  }

  void saveToken({required String token}) async {
    final prefs = await getInstance();
    await prefs.setString("token", token);
  }

  void saveCurrentDeviceToken({required String? deviceToken}) async {
    final prefs = await getInstance();
    if (prefs.containsKey("deviceToken")) {
      var fetchedToken = prefs.getString("deviceToken");
      if (deviceToken != "" && fetchedToken != deviceToken) {
        await prefs.setString("deviceToken", deviceToken ?? "");
      }
    } else {
      await prefs.setString("deviceToken", deviceToken ?? "");
    }
    return;
  }

  void deleteToken() async {
    final prefs = await getInstance();
    await prefs.remove("token");
    await prefs.remove("deviceToken");
  }

  Future<String?> getToken({required String key}) async {
    final prefs = await getInstance();
    if (prefs.containsKey(key)) {
      return prefs.getString(key);
    }

    return null;
  }
}
