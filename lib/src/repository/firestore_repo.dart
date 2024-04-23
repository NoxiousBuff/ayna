import 'package:ayna/src/models/user.dart';
import 'package:ayna/src/repository/hive_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreRepo {
   FireStoreRepo():super();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _hiveRepo = HiveRepo();

  final CollectionReference subsCollection = _firestore.collection('users');

  Future<void> createUserInFirebase({
    Function? onError,
    required User user,
    required String name,
  }) async {
    try {
      await subsCollection.doc(user.uid).set({
        'name': name,
        'email': user.email,
        'id': user.uid,
      });
      _hiveRepo.saveAndReplace(user.uid, {'name': name, 'email': user.email});
    } catch (e) {
      print('Creating user in firebase failed. Error : $e');
      if (onError != null) onError();
    }
  }

  Future<FirebaseUser> getUserFromFirebase(String userUid) async {
    print('userUid:$userUid');

    if (userUid.isNotEmpty) {
      final userDoc = await subsCollection.doc(userUid).get();
      if (!userDoc.exists) {
        print('We have no user with id $userUid in our database');
        return FirebaseUser.empty;
      }

      final userData = userDoc.data();
      print('User found. Data: $userData');

      return FirebaseUser.fromFireStore(userDoc);
    } else {
      print('User cannot be empty. Please fill it correctly.');
    }
    return FirebaseUser.empty;
  }
}
