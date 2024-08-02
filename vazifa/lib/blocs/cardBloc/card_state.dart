import 'package:vazifa/data/models/card.dart';

abstract class CreditCardState{
  const CreditCardState();

  @override
  List<Object> get props => [];
}

class CreditCardLoading extends CreditCardState {}

class CreditCardLoaded extends CreditCardState {
  final List<CreditCard> creditCards;

  const CreditCardLoaded({required this.creditCards});

  @override
  List<Object> get props => [creditCards];
}

class CreditCardError extends CreditCardState {}
