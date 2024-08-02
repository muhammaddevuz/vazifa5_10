
import 'package:vazifa/data/models/user.dart';

abstract class UserEvent {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUsers extends UserEvent {}

class UsersUpdated extends UserEvent {
  final List<User> users;

  const UsersUpdated(this.users);

  @override
  List<Object> get props => [users];
}
