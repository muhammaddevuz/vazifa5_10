import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:vazifa/blocs/userBloc/user_event.dart';
import 'package:vazifa/blocs/userBloc/user_state.dart';
import 'package:vazifa/data/models/user.dart';
import 'package:vazifa/data/repositories/user_repository.dart';
class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  StreamSubscription<List<User>>? _userSubscription;

  UserBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(UserLoading()) {
    on<LoadUsers>((event, emit) async {
      _userSubscription?.cancel();
      _userSubscription = _userRepository.getUsers().listen(
        (users) {
          add(UsersUpdated(users));
        },
      );
    });

    on<UsersUpdated>((event, emit) {
      emit(UserLoaded(users: event.users));
    });
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
