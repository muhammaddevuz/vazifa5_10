import 'package:vazifa/data/models/card.dart';

abstract class CreditCardEvent{
  const CreditCardEvent();
}

class LoadCreditCards extends CreditCardEvent {}

class CreditCardsUpdated extends CreditCardEvent {
  final List<CreditCard> creditCards;

  const CreditCardsUpdated(this.creditCards);

  @override
  List<Object> get props => [creditCards];
}
