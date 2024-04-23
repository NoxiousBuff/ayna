import 'package:ayna/src/bloc/auth/auth_event.dart';
import 'package:ayna/src/bloc/auth/auth_state.dart';
import 'package:ayna/src/repository/auth_repo.dart';
import 'package:bloc/bloc.dart';

class AuthBloc extends Bloc<AuthEvents, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<SignUp>(_signup);
    on<Login>(_login);
    on<Logout>(_logout);
  }

  final _authRepo = AuthRepo();

  void _signup(SignUp event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: Status.loading));
    print('signup');
    await _authRepo.signUp(
        email: event.email,
        password: event.password,
        name: event.name,
        onComplete: () {
          emit(state.copyWith(
              status: Status.success,
              authenticationStatus: AuthenticationStatus.authenticated));
        },
        onError: () {
          emit(state.copyWith(
              status: Status.error,
              authenticationStatus: AuthenticationStatus.unAuthenticated));
        });
    print('done');
  }

  void _login(Login event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: Status.loading));
    print('login');
    await _authRepo.logIn(
        email: event.email,
        password: event.password,
        onComplete: () {
          emit(state.copyWith(
              status: Status.success,
              authenticationStatus: AuthenticationStatus.authenticated));
          print('current status : ${state.status}');
          print('current status : ${state.authenticationStatus}');
        },
        onError: () {
          print('before emiting error');
          emit(state.copyWith(
              status: Status.error,
              authenticationStatus: AuthenticationStatus.unAuthenticated));
          print('current status : ${state.status}');
          print(' after emiting error');
        });

    print('done');
  }

  void _logout(Logout event, Emitter<AuthState> emit) async {
    await _authRepo.signOut(onSignOut: () {
      emit(state.copyWith(
          authenticationStatus: AuthenticationStatus.unAuthenticated));
      print('current status : ${state.authenticationStatus}');
      
    });
  }
}
