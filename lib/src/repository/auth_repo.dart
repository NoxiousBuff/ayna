import 'package:ayna/src/models/user.dart';
import 'package:ayna/src/repository/firestore_repo.dart';
import 'package:ayna/src/repository/hive_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  AuthRepo();

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  final _hiveRepo = HiveRepo();

  static User? liveUser = FirebaseAuth.instance.currentUser;

  final _fireStoreRepo = FireStoreRepo();

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    Function? onComplete,
    Function? accountExists,
    Function? weakPassword,
    required onError,
  }) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        await _fireStoreRepo.createUserInFirebase(
            user: value.user!, name: name);
        if (onComplete != null) await onComplete();
        print('User has been created in the firebase authentication.');
        return value;
      }).onError((error, stackTrace) async => await onError());
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> logIn({
    required String email,
    required String password,
    required Function onComplete,
    Function? noAccountExists,
    Function? invalidEmail,
    Function? wrongPassword,
    required Function onError,
  }) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        print('The User with email : $email has been successfully logged In');
        FirebaseUser user =
            await _fireStoreRepo.getUserFromFirebase(value.user!.uid);
        if (user != FirebaseUser.empty) {
          _hiveRepo.saveAndReplace(
              user.id, {'name': user.name, 'email': user.email});
        } else {
          throw Error();
        }
        await onComplete();
      }).onError((error, stackTrace) async => await onError());
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  signOut({required Function onSignOut, Function? onError}) async {
    try {
      await _auth.signOut().then((value) async {
        await _hiveRepo.deleteData();
        onSignOut();
        print('The user has been signed out successfully.');
      });
    } catch (e) {
      if (onError != null) onError();
    }
  }

  Stream<FirebaseUser> get user {
    return _auth.authStateChanges().map((user) {
      final firebaseUser = user == null
          ? FirebaseUser.empty
          : FirebaseUser(
              id: user.uid,
              email: user.email!,
              name: user.displayName!,
            );

      return firebaseUser;
    });
  }
}
