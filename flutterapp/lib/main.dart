import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/constants/routes.dart';
import 'package:flutterapp/services/auth/bloc/auth_bloc.dart';
import 'package:flutterapp/services/auth/bloc/auth_event.dart';
import 'package:flutterapp/services/auth/bloc/auth_state.dart';
import 'package:flutterapp/services/auth/firebase_auth_provider.dart';
import 'package:flutterapp/views/detail.dart';
import 'package:flutterapp/views/full_size_image.dart';
import 'package:flutterapp/views/login.dart';
import 'package:flutterapp/views/navholder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const StartingPage(),
      ),
      routes: {
        detailRoute: (context) => const DetailWindow(),
        fullSizeImageRoute: (context) => const FullSizeImageWindow()
      },
    );
  }
}

class StartingPage extends StatelessWidget {
  const StartingPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const NavHolder();
        } else if (state is AuthStateLoggedOut ||
            state is AuthStateRegistering) {
          return const LoginView();
        } else {
          return const Scaffold(
              body: Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator()));
        }
      },
    );
  }
}
