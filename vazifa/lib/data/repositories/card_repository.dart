// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vazifa/data/model/card_model.dart';
import 'package:vazifa/data/model/user_model.dart';

class CardRepository {
  final CollectionReference cardsCollection =
      FirebaseFirestore.instance.collection('cards');
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> addCard(CardModel card) async {
    try {
      await cardsCollection.add(card.toMap());
      await _updateUserCards(card.userId, card);
    } catch (e) {
      print("Error adding card: $e");
      rethrow;
    }
  }

  Future<void> updateCard(CardModel card) async {
    try {
      await cardsCollection.doc(card.id).update(card.toMap());
    } catch (e) {
      print("Error updating card: $e");
      rethrow;
    }
  }

  Future<void> deleteCard(String id) async {
    try {
      await cardsCollection.doc(id).delete();
    } catch (e) {
      print("Error deleting card: $e");
      rethrow;
    }
  }

  Future<List<CardModel>> fetchCards(String userId) async {
    try {
      final querySnapshot =
          await cardsCollection.where('userId', isEqualTo: userId).get();
      return querySnapshot.docs
          .map((doc) =>
              CardModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      print("Error fetching cards: $e");
      rethrow;
    }
  }

  Future<void> _updateUserCards(String userId, CardModel card) async {
    try {
      DocumentSnapshot userDoc = await usersCollection.doc(userId).get();
      UserModel user = UserModel.fromDocumentSnapshot(userDoc);
      user.cards.add(card);
      await usersCollection.doc(userId).update(user.toMap());
    } catch (e) {
      print("Error updating user cards: $e");
      rethrow;
    }
  }

  Future<CardModel> fetchCardByNumber(String cardNumber) async {
    try {
      final querySnapshot = await cardsCollection
          .where('number', isEqualTo: cardNumber)
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return CardModel.fromMap(
            querySnapshot.docs.first.data() as Map<String, dynamic>,
            querySnapshot.docs.first.id);
      } else {
        throw Exception("Card not found");
      }
    } catch (e) {
      print("Error fetching card by number: $e");
      rethrow;
    }
  }

  Future<void> updateCardBalance(String cardId, double newBalance) async {
    try {
      await cardsCollection.doc(cardId).update({'balance': newBalance});
    } catch (e) {
      print("Error updating card balance: $e");
      rethrow;
    }
  }
}
