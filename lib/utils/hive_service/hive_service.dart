import 'package:eye_hospital/utils/hive_service/userdetail.dart';
import 'package:hive/hive.dart';

class HiveService {
  static final Box<UserDetails> _box = Hive.box<UserDetails>('userBox');

  static Future<void> saveUser(UserDetails user) async {
    await _box.put('user', user);
  }

  static UserDetails? getUser() {
    return _box.get('user');
  }

  static Future<void> saveToken(String token) async {
    await _box.put(
      'token',
      UserDetails(name: "", dob: "", gender: "", token: token),
    );
  }

  static String? getToken() {
    return _box.get('token')?.token;
  }

  static Future<void> logout() async {
    await _box.clear();
  }

  static bool isLogin() {
    return _box.containsKey('user');
  }
}
