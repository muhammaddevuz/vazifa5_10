import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vazifa/data/models/card.dart';
import 'package:vazifa/data/models/user.dart';

class UserRepository {
  final FirebaseFirestore _firestore;

  UserRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<List<CreditCard>> getCreditCards() {
    return _firestore.collection('credit_cards').snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => CreditCard.fromFirestore(doc))
          .toList(),
    );
  }

  Stream<List<User>> getUsers() {
    return _firestore.collection('users').snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => User.fromFirestore(doc))
          .toList(),
    );
  }
}
