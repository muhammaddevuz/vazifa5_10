import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:vazifa/blocs/cardBloc/card_event.dart';
import 'package:vazifa/blocs/cardBloc/card_state.dart';
import 'package:vazifa/data/models/card.dart';
import 'package:vazifa/data/repositories/user_repository.dart';

class CreditCardBloc extends Bloc<CreditCardEvent, CreditCardState> {
  final UserRepository _userRepository;
  StreamSubscription<List<CreditCard>>? _creditCardSubscription;

  CreditCardBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(CreditCardLoading()) {
    on<LoadCreditCards>((event, emit) async {
      _creditCardSubscription?.cancel();
      _creditCardSubscription = _userRepository.getCreditCards().listen(
        (creditCards) {
          add(CreditCardsUpdated(creditCards));
        },
      );
    });

    on<CreditCardsUpdated>((event, emit) {
      emit(CreditCardLoaded(creditCards: event.creditCards));
    });
  }

  @override
  Future<void> close() {
    _creditCardSubscription?.cancel();
    return super.close();
  }
}
