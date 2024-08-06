import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/card/card_bloc.dart';
import 'package:vazifa/blocs/card/card_state.dart';
import 'package:vazifa/ui/screens/home_screen.dart';

class CardScreen extends StatefulWidget {
  final String userId;

  const CardScreen({required this.userId, super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Gradient> gradients = [
      const LinearGradient(colors: [Colors.blue, Colors.lightBlueAccent]),
      const LinearGradient(colors: [Colors.red, Colors.orange]),
      const LinearGradient(colors: [Colors.green, Colors.lightGreenAccent]),
      const LinearGradient(colors: [Colors.purple, Colors.purpleAccent]),
      const LinearGradient(colors: [Colors.pink, Colors.pinkAccent]),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (ctx) => const HomeScreen()),
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
        title: const Text(
          'Cards',
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<CardBloc, CardState>(
                builder: (context, state) {
                  if (state is CardLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CardLoaded) {
                    return ListView.builder(
                      itemCount: state.cards.length,
                      itemBuilder: (context, index) {
                        final card = state.cards[index];
                        final gradient = gradients[index % gradients.length];
                        return Container(
                          height: 200,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            gradient: gradient,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                card.fullname,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(card.number,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18)),
                              const SizedBox(height: 5),
                              Text('\$${card.balance.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18)),
                              const SizedBox(height: 5),
                              Text(card.expiryDate,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18)),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (state is CardOperationFailure) {
                    return Center(
                      child: Text('Failed to load cards: ${state.error}'),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
