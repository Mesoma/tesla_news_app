import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


abstract class AuthRepository{

  Future login(AppUser user);
  Future<AppUser?> getUserData();

}




class AuthRepositoryLocal implements AuthRepository  {

  @override
  Future login(AppUser user) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();

      await pref.setString("email", user.email);
      await pref.setString("password", user.password);
      await pref.setString("name", user.name);

      String userDataJson = jsonEncode(user.toJson());
      var saved = await pref.setString("userData", userDataJson);
      await pref.setBool("isLoggedIn", true);
      if (saved) {
      } else {
      }
    } catch (e) {
    }
  }


  @override
  Future<AppUser?> getUserData() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? userDataString = pref.getString("userData");
      if (userDataString != null) {
        var userDataMap = jsonDecode(userDataString);

        return AppUser.fromJson(userDataMap);
      } else {

        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}


class AuthRepositoryRemote implements AuthRepository{

  @override
  Future<AppUser?> getUserData() {
    // TODO: implement getUserData
    throw UnimplementedError();
  }

  @override
  Future login(AppUser user) {
    // TODO: implement login
    throw UnimplementedError();
  }

}
















class Bloc {


  final AuthRepository repository;

  Bloc(this.repository);

  void login(){
    repository.login(AppUser(name: "name", email: "email", password: "password"));

  }
}










void main() async {
  try {


    final bloc = Bloc(AuthRepositoryLocal());

    bloc.login();


    // print("main running");
    // final AuthRepository helper = AuthRepositoryLocal();
    // await helper.login(AppUser(name: "messo", email: "mess@gmail.com", password: "password"));
    // await helper.getUserData();
  } catch (e) {
    print("error${e}");
  }
}

class AppUser {
  String name;
  String email;
  String password;

  AppUser({required this.name, required this.email, required this.password});

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(name: json["name"], email: json["email"], password: json["password"]);

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
    };
  }
}