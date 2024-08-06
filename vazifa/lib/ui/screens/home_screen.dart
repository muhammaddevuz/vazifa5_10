import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vazifa/ui/screens/card_screen.dart';
import 'package:vazifa/ui/screens/payments_screen.dart';
import 'package:vazifa/ui/widgets/custom_drawer_widget.dart';
import 'package:vazifa/ui/widgets/show_dilog_card_add.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (ctx) => CardScreen(userId: userId),
                ),
              );
            },
            icon: const Icon(Icons.card_travel_outlined),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const PaymentScreen(),
                ),
              );
            },
            icon: const Icon(Icons.transfer_within_a_station_rounded),
          ),
        ],
      ),
      drawer: const CustomDrawerWidget(),
      body: const Column(),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Colors.amber.shade800,
        onPressed: () => showAddCardDialog(context, userId),
        child: const Icon(Icons.add, size: 30, color: Colors.white),
      ),
    );
  }
}
