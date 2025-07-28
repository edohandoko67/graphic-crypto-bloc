import 'package:get_storage/get_storage.dart';

class Storage {
  final GetStorage _storage = GetStorage();

  void saveToken(String token) => _storage.write("session_id", token);
  void saveName(String name) => _storage.write("nama", name);
  void login() => _storage.write("isLoggedIn", true);
  void logout() {
    _storage.write("isLoggedIn", false);
  }

  bool isLogin() => _storage.read<bool>("isLoggedIn") ?? false;
  String? getToken() => _storage.read<String>("session_id");
  String? getName() => _storage.read<String>("name");
}