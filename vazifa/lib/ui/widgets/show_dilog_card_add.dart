import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/card/card_bloc.dart';
import 'package:vazifa/blocs/card/card_event.dart';
import 'package:vazifa/data/model/card_model.dart';

void showAddCardDialog(BuildContext context, String userId) {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController balanceController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController cardNameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Add New Card',
            style: TextStyle(
              fontSize: 18,
            )),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: fullNameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12.5)),
                    borderSide: BorderSide(
                      color: Colors.amber.shade900,
                      width: 3,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12.5)),
                    borderSide: BorderSide(
                      color: Colors.amber.shade900,
                      width: 3,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: numberController,
                decoration: InputDecoration(
                  labelText: 'Card Number',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12.5)),
                    borderSide: BorderSide(
                      color: Colors.amber.shade900,
                      width: 3,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12.5)),
                    borderSide: BorderSide(
                      color: Colors.amber.shade900,
                      width: 3,
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: expiryDateController,
                decoration: InputDecoration(
                  labelText: 'Expiry Date (yyyy.MM.dd)',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12.5)),
                    borderSide: BorderSide(
                      color: Colors.amber.shade900,
                      width: 3,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12.5)),
                    borderSide: BorderSide(
                      color: Colors.amber.shade900,
                      width: 3,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: balanceController,
                decoration: InputDecoration(
                  labelText: 'Balance',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12.5)),
                    borderSide: BorderSide(
                      color: Colors.amber.shade900,
                      width: 3,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12.5)),
                    borderSide: BorderSide(
                      color: Colors.amber.shade900,
                      width: 3,
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: bankNameController,
                decoration: InputDecoration(
                  labelText: 'Bank Name',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12.5)),
                    borderSide: BorderSide(
                      color: Colors.amber.shade900,
                      width: 3,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12.5)),
                    borderSide: BorderSide(
                      color: Colors.amber.shade900,
                      width: 3,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: cardNameController,
                decoration: InputDecoration(
                  labelText: 'Card Name',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12.5)),
                    borderSide: BorderSide(
                      color: Colors.amber.shade900,
                      width: 3,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12.5)),
                    borderSide: BorderSide(
                      color: Colors.amber.shade900,
                      width: 3,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: typeController,
                decoration: InputDecoration(
                  labelText: 'Type',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12.5)),
                    borderSide: BorderSide(
                      color: Colors.amber.shade900,
                      width: 3,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12.5)),
                    borderSide: BorderSide(
                      color: Colors.amber.shade900,
                      width: 3,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FilledButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FilledButton(
                child: const Text('Add Card'),
                onPressed: () {
                  String expiryDateStr = expiryDateController.text;
                  List<String> dateParts = expiryDateStr.split('.');
                  String formattedDate =
                      '${dateParts[0]}-${dateParts[1]}-${dateParts[2]}';
                  try {
                    final card = CardModel(
                      id: '',
                      fullname: fullNameController.text,
                      number: numberController.text,
                      expiryDate: DateTime.parse(formattedDate),
                      balance: double.parse(balanceController.text),
                      bankName: bankNameController.text,
                      cardName: cardNameController.text,
                      type: typeController.text,
                      userId: userId,
                    );

                    BlocProvider.of<CardBloc>(context).add(AddCard(card));

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Card added successfully!'),
                      ),
                    );

                    Navigator.of(context).pop();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error adding card: ${e.toString()}'),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      );
    },
  );
}
