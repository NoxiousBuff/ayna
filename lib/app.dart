import 'package:ayna/src/ui/default/default_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  bool get ifCurrentUserExists => FirebaseAuth.instance.currentUser != null; 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultView(),
    );
  }
}
