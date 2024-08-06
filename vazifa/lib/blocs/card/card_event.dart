import 'package:equatable/equatable.dart';
import 'package:vazifa/data/model/card_model.dart';

abstract class CardEvent extends Equatable {
  const CardEvent();

  @override
  List<Object> get props => [];
}

class LoadCards extends CardEvent {
  final String userId;

  const LoadCards(this.userId);

  @override
  List<Object> get props => [userId];
}

class AddCard extends CardEvent {
  final CardModel card;

  const AddCard(this.card);

  @override
  List<Object> get props => [card];
}

class UpdateCard extends CardEvent {
  final CardModel card;

  const UpdateCard(this.card);

  @override
  List<Object> get props => [card];
}

class DeleteCard extends CardEvent {
  final String cardId;

  const DeleteCard(this.cardId);

  @override
  List<Object> get props => [cardId];
}

class TransferMoney extends CardEvent {
  final String senderCardNumber;
  final String recipientCardNumber;
  final double amount;
  final String userId;

  const TransferMoney({
    required this.senderCardNumber,
    required this.recipientCardNumber,
    required this.amount,
    required this.userId,
  });
}
