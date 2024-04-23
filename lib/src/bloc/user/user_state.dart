import 'package:equatable/equatable.dart';

enum GettingUsersState { initial, loading, success, error }

class UserState extends Equatable {
  final GettingUsersState gettingUsersState;

  const UserState({this.gettingUsersState = GettingUsersState.initial});

  UserState copyWith(GettingUsersState? gettingUsersState) {
    return UserState(
        gettingUsersState: gettingUsersState ?? GettingUsersState.loading);
  }

  @override
  List<Object?> get props => [gettingUsersState];
}
