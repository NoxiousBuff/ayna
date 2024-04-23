import 'package:equatable/equatable.dart';

abstract class UserEvents extends Equatable {
  const UserEvents();

  @override
  List<Object> get props => [];
}

class GetAllUsers extends UserEvents {}
