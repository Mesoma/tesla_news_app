import 'package:everything_app/domain/user/user_model.dart';

//use for further scalability
abstract class UserRepo {
  Future<void> login(User user);

  Future<void> logout();

  Future<User?> getUser();
}