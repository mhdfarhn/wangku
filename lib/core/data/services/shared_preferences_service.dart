import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  Future<bool> isAccountExist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final name = prefs.getString('name');
      bool exist = name != null ? true : false;

      return exist;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> createAccount(String name) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', name);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String?> getAccount() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final account = prefs.getString('name');
      return account;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> updateAccount(String name) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('name');
      await prefs.setString('name', name);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> removeAccount() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('name');
    } catch (e) {
      throw e.toString();
    }
  }
}
