import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vazifa/data/model/card_model.dart';

class UserModel {
  String id;
  String fullName;
  String email;
  List<CardModel> cards;
  String firstname;
  String lastname;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.cards,
    required this.firstname,
    required this.lastname,
  });

  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
    return UserModel(
      id: documentId,
      fullName: data['fullName'],
      email: data['email'],
      cards: (data['cards'] as List)
          .map((item) => CardModel.fromMap(item, item['id']))
          .toList(),
      firstname: data['firstname'],
      lastname: data['lastname'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'cards': cards.map((card) => card.toMap()).toList(),
      'firstname': firstname,
      'lastname': lastname,
    };
  }

  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
    String? passportId,
    List<CardModel>? cards,
    String? firstname,
    String? lastname,
    String? imageUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      cards: cards ?? this.cards,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
    );
  }

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      firstname: data['firstname'] ?? 'null',
      lastname: data['lastname'] ?? 'null',
      email: data['email'] ?? 'null',
      cards: data[''] ?? [],
      fullName: data['fullName'] ?? 'null',
    );
  }
}
