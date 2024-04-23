import 'package:equatable/equatable.dart';

enum Status { initial, loading, success, error }

enum AuthenticationStatus { authenticated, unAuthenticated }

class AuthState extends Equatable {
  final Status status;
  final AuthenticationStatus authenticationStatus;

  const AuthState(
      {this.status = Status.initial,
      this.authenticationStatus = AuthenticationStatus.unAuthenticated});

  AuthState copyWith(
      {Status? status, AuthenticationStatus? authenticationStatus}) {
    return AuthState(
      status: status ?? this.status,
      authenticationStatus:
          authenticationStatus ?? AuthenticationStatus.unAuthenticated,
    );
  }

  @override
  List<Object?> get props => [status];
}

// final String email;
//   final String password;
//   final String name;
//   final LoginStatus loginStatus;

//   const AuthState(
//       {this.email = '',
//       this.password = '',
//       this.name = '',
//       this.loginStatus = LoginStatus.initial});

//   AuthState copyWith(
//       {String? email,
//       String? password,
//       String? name,
//       LoginStatus? loginStatus}) {
//     return AuthState(
//       email: email ?? this.email,
//       password: password ?? this.password,
//       name: name ?? this.name,
//       loginStatus: loginStatus ?? this.loginStatus,
//     );
//   }

//   @override
//   List<Object?> get props => [email, password, name, loginStatus];