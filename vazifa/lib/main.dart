import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/cardBloc/card_bloc.dart';
import 'package:vazifa/blocs/cardBloc/card_event.dart';
import 'package:vazifa/blocs/userBloc/user_bloc.dart';
import 'package:vazifa/blocs/userBloc/user_event.dart';
import 'package:vazifa/data/repositories/user_repository.dart';
import 'package:vazifa/ui/screen/login_screen.dart';
import 'package:vazifa/ui/screen/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CreditCardBloc>(
          create: (context) =>
              CreditCardBloc(userRepository: UserRepository())..add(LoadCreditCards()),
        ),
        BlocProvider<UserBloc>(
          create: (context) =>
              UserBloc(userRepository: UserRepository())..add(LoadUsers()),
        ),
      ],
      child: MaterialApp(
        home:StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const MainScreen();
            }

            return const LoginScreen();
          },
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
