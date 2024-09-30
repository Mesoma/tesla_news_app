import 'package:everything_app/domain/user/user_model.dart';
import 'package:everything_app/domain/user/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedUserRepo implements UserRepo {
  @override
  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? username = prefs.getString('username');
    final bool? isLoggedIn = prefs.getBool('isLoggedIn');

    User prefUser = User(
        username: username ?? "ANONYMOUS", isLoggedIn: isLoggedIn ?? false);

    return prefUser;
  }

  @override
  Future<void> login(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', user.username);
    await prefs.setBool('isLoggedIn', !user.isLoggedIn);
  }

  @override
  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.setBool('isLoggedIn', false);
  }
}
