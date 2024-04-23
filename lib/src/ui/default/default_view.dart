import 'package:ayna/src/bloc/auth/auth_bloc.dart';
import 'package:ayna/src/ui/views/auth/auth_view.dart';
import 'package:ayna/src/ui/views/home/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DefaultView extends StatelessWidget {
  DefaultView({super.key});

  final _authBloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authBloc,
      //   child: BlocBuilder<AuthBloc, AuthState>(
      //       buildWhen: (previous, current) => previous.authenticationStatus != current.authenticationStatus,
      //       builder: (context, state) {
      //     return state.authenticationStatus == AuthenticationStatus.authenticated
      //         ? HomeView()
      //         : const AuthView();
      //   }),
      // );
      // return StreamBuilder(
      //     stream: FirebaseAuth.instance.authStateChanges(),
      //     builder: (context, user) {
      //       if (user.data != null) {
      //         return HomeView();
      //       } else {
      //         return AuthView();
      //       }
      //     });
      child:
          FirebaseAuth.instance.currentUser != null ? HomeView() : AuthView(),
    );
  }
}
