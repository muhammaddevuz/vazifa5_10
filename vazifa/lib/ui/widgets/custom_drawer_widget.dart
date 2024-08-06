import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vazifa/data/model/user_model.dart';
import 'package:vazifa/data/repositories/user_repositories.dart';
import 'package:vazifa/ui/screens/auth/login_screen.dart';
import 'package:vazifa/ui/screens/card_screen.dart';
import 'package:vazifa/ui/screens/payments_screen.dart';

class CustomDrawerWidget extends StatefulWidget {
  const CustomDrawerWidget({super.key});

  @override
  State<CustomDrawerWidget> createState() => _CustomDrawerWidgetState();
}

class _CustomDrawerWidgetState extends State<CustomDrawerWidget> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final userFirebaseService = UserRepository();
  User? _user;

  @override
  void initState() {
    super.initState();
    auth.authStateChanges().listen((User? user) {
      setState(() {
        _user = user;
        if (user != null) {
          _checkTokenValidity(user);
        }
      });
    });
  }

  Future<void> _checkTokenValidity(User user) async {
    try {
      IdTokenResult tokenResult = await user.getIdTokenResult(true);
      DateTime? expirationTime = tokenResult.expirationTime;
      if (expirationTime != null && expirationTime.isBefore(DateTime.now())) {
        await auth.signOut();
      }
    } catch (e) {
      // ignore: avoid_print
      print('Tokenning amal qilish muddatini tekshirishda xato: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                height: 260,
                width: double.infinity,
                color: Colors.blue,
                child: _user == null
                    ? const Center(
                        child: Text('Foydalanuvchi topilmadi',
                            style: TextStyle(color: Colors.white)))
                    : StreamBuilder<DocumentSnapshot>(
                        stream: userFirebaseService.getUserById(
                            FirebaseAuth.instance.currentUser!.uid),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                  'Xatolik yuz berdi: ${snapshot.error}',
                                  style: const TextStyle(color: Colors.white)),
                            );
                          }

                          final userDoc = snapshot.data!;
                          if (!userDoc.exists) {
                            return const Center(
                              child: Text(
                                  'Foydalanuvchi ma\'lumotlari mavjud emas',
                                  style: TextStyle(color: Colors.white)),
                            );
                          }
                          final user = UserModel.fromDocumentSnapshot(userDoc);

                          final firstName = user.firstname;
                          final lastName = user.lastname;
                          final email = user.email;

                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '$firstName $lastName',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  email,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushReplacement(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => CardScreen(
                                userId: auth.currentUser!.uid,
                              )));
                },
                leading: const Icon(Icons.credit_card),
                title: const Text('Cards'),
                trailing: const Icon(Icons.chevron_right_rounded),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushReplacement(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => const PaymentScreen()));
                },
                leading: const Icon(Icons.transfer_within_a_station_rounded),
                title: const Text('Transfer'),
                trailing: const Icon(Icons.chevron_right_rounded),
              ),
            ],
          ),
          ListTile(
            onTap: () async {
              await auth.signOut();
              Navigator.pushReplacement(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(builder: (ctx) => const LoginScreen()));
            },
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Chiqish'),
            trailing: const Icon(Icons.chevron_right_rounded),
          ),
        ],
      ),
    );
  }
}
