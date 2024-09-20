
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:everything_app/domain/user/user_model.dart';

import '../domain/user/user_repository.dart';

class UserCubit extends Cubit<User> {

  final UserRepo userRepo;

  UserCubit(this.userRepo) : super(User(username: "", password: "")){
    userRepo.getUser();
}

}