part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {}

class UsersLoaded extends UserState {
  final List<UserModel> users;

  const UsersLoaded(this.users);

  @override
  List<Object> get props => [users];
}

class UserOperationFailure extends UserState {
  final String error;

  const UserOperationFailure(this.error);

  @override
  List<Object> get props => [error];
}
