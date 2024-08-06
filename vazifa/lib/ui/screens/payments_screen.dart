// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vazifa/ui/screens/home_screen.dart';
import 'package:vazifa/ui/widgets/formated_card_widget.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PaymentScreenState();
  }
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _senderCardNumberController = TextEditingController();
  final _recipientCardNumberController = TextEditingController();
  final _amountController = TextEditingController();
  // ignore: unused_field
  late final String _userId;

  @override
  void initState() {
    super.initState();
    _userId = FirebaseAuth.instance.currentUser?.uid ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (ctx) => const HomeScreen()));
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
            )),
        title: const Text(
          'Transfer Money',
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Icon(Icons.abc, size: 200, color: Colors.amber.shade700),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _senderCardNumberController,
                  inputFormatters: [CardNumberFormatter()],
                  decoration: InputDecoration(
                    labelText: 'Sender Card Number',
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.5)),
                      borderSide: BorderSide(
                        color: Colors.amber.shade900,
                        width: 3,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.5)),
                      borderSide: BorderSide(
                        color: Colors.amber.shade900,
                        width: 3,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the sender card number';
                    }
                    final cardNumber = value.replaceAll(' ', '');
                    if (cardNumber.length != 16) {
                      return 'Invalid card number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _recipientCardNumberController,
                  decoration: InputDecoration(
                    labelText: 'Recipient Card Number',
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.5)),
                      borderSide: BorderSide(
                        color: Colors.amber.shade900,
                        width: 3,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.5)),
                      borderSide: BorderSide(
                        color: Colors.amber.shade900,
                        width: 3,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the recipient card number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _amountController,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.5)),
                      borderSide: BorderSide(
                        color: Colors.amber.shade900,
                        width: 3,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.5)),
                      borderSide: BorderSide(
                        color: Colors.amber.shade900,
                        width: 3,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the amount';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 200),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print('Form is valid');
                        final senderCardNumber =
                            _senderCardNumberController.text;
                        final recipientCardNumber =
                            _recipientCardNumberController.text;
                        final amount = double.parse(_amountController.text);
                        print('Sender Card Number: $senderCardNumber');
                        print('Recipient Card Number: $recipientCardNumber');
                        print('Amount: $amount');
                      } else {
                        print('Form is invalid');
                      }
                    },
                    child: const Text('Transfer'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
