
class CardModel {
  String id;
  String fullname;
  String number;
  String expiryDate;
  double balance;
  String userId;

  CardModel({
    required this.id,
    required this.fullname,
    required this.number,
    required this.expiryDate,
    required this.balance,
    required this.userId,
  });

  factory CardModel.fromMap(Map<String, dynamic> data, String documentId) {
    return CardModel(
      id: documentId,
      fullname: data['fullname'],
      number: data['number'],
      expiryDate: data['expiryDate'],
      balance: data['balance'].toDouble(),
      userId: data['userId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fullname': fullname,
      'number': number,
      'expiryDate': expiryDate,
      'balance': balance,
      'userId': userId,
    };
  }

  CardModel copyWith({
    String? id,
    String? fullname,
    String? number,
    String? expiryDate,
    double? balance,
    String? bankName,
    String? cardName,
    String? type,
    String? userId,
  }) {
    return CardModel(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
      number: number ?? this.number,
      expiryDate: expiryDate ?? this.expiryDate,
      balance: balance ?? this.balance,
      userId: userId ?? this.userId,
    );
  }
}
