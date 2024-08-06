// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vazifa/data/model/user_model.dart';
import 'package:vazifa/data/repositories/user_repositories.dart';
import 'package:vazifa/ui/screens/home_screen.dart';

class UserAddWidgets extends StatefulWidget {
  const UserAddWidgets({super.key});

  @override
  State<UserAddWidgets> createState() => _UserAddWidgetsState();
}

class _UserAddWidgetsState extends State<UserAddWidgets> {
  final formKey = GlobalKey<FormState>();
  final UserRepository userRepository = UserRepository();

  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final passportIdController = TextEditingController();

  bool isLoading = false;

  void submit() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      setState(() {
        isLoading = true;
      });
      try {
        final curUser = FirebaseAuth.instance.currentUser;

        final userModel = UserModel(
          id: curUser!.uid,
          fullName: '${fnameController.text} ${lnameController.text}',
          email: curUser.email!,
          passportId: passportIdController.text,
          cards: [], // Bosh lista
          firstname: fnameController.text,
          lastname: lnameController.text,
          imageUrl: "",
        );

        await userRepository.addUser(userModel);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (ctx) {
              return const HomeScreen();
            },
          ),
        );
      } on Exception catch (e) {
        String message = e.toString();
        if (e.toString().contains("EMAIL_EXISTS")) {
          message = "Email mavjud";
        }
        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text("Xatolik"),
              content: Text(message),
            );
          },
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                const Icon(Icons.abc, size: 200, color: Colors.amber),
                const SizedBox(height: 50),
                TextFormField(
                  controller: fnameController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    border: const OutlineInputBorder(),
                    hintText: "Ismingiz",
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
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Iltimos ismingizni kiriting";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: lnameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: "Familyangiz",
                    prefixIcon: const Icon(Icons.person),
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
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Iltimos familyangizni kiriting";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: passportIdController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: "Passport ID",
                    prefixIcon: const Icon(Icons.article),
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
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Iltimos passport ID ni kiriting";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () async {
                    submit();
                  },
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.amber.shade900,
                          width: 3,
                        )),
                    child: Center(
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              'Kirish',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                    ),
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
