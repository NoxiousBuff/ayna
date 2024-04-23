import 'package:equatable/equatable.dart';

abstract class AuthEvents extends Equatable {
  const AuthEvents();

  @override
  List<Object> get props => [];
}

class SignUp extends AuthEvents {
  const SignUp({required this.email, required this.name, required this.password});

  final String email;
  final String password;
  final String name;

  @override
  List<Object> get props => [email, password, name];
}

class Login extends AuthEvents {
  const Login({required this.email,required this.password});

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class Logout extends AuthEvents {}
