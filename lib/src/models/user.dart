import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class FirebaseUser extends Equatable {
  const FirebaseUser({
    required this.id,
    required this.email,
    required this.name,
  });

  final String email;
  final String id;
  final String name;

  static const empty = FirebaseUser(id: '', email: '', name: '');

  bool get isEmpty => this == FirebaseUser.empty;

  bool get isNotEmpty => this != FirebaseUser.empty;

  factory FirebaseUser.fromFireStore(DocumentSnapshot doc) {
    return FirebaseUser(id: doc['id'], email: doc['email'], name: doc['name']);
  }

  @override
  List<Object?> get props => [email, id, name];
}
