import 'package:cloud_firestore/cloud_firestore.dart';

class CreditCard {
  final String id;
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final double balance;

  CreditCard({
    required this.id,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.balance,
  });

  factory CreditCard.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return CreditCard(
      id: doc.id,
      cardNumber: data['cardNumber'] ?? '',
      cardHolderName: data['cardHolderName'] ?? '',
      expiryDate: data['expiryDate'] ?? '',
      balance: double.parse(data['balance']),
    );
  }
}
