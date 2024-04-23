import 'package:ayna/app.dart';
import 'package:ayna/firebase_options.dart';
import 'package:ayna/src/bloc/auth/auth_bloc.dart';
import 'package:ayna/src/bloc/user/user_bloc.dart';
import 'package:ayna/src/repository/hive_repo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/bloc/app_bloc.dart';

Future<void> main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await HiveRepo.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        BlocProvider<UserBloc>(create: (context) => UserBloc()),
      ],
      child: const MyApp()),
  );
}
