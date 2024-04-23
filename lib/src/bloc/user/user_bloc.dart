import 'package:ayna/src/bloc/user/user_event.dart';
import 'package:ayna/src/bloc/user/user_state.dart';
import 'package:bloc/bloc.dart';

class UserBloc extends Bloc<UserEvents, UserState> {
  UserBloc() : super(const UserState()) {
    // on<GetAllUsers>(_gettingAllUsers);
  }

  
}
