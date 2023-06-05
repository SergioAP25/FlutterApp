import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/constants/routes.dart';
import 'package:flutterapp/data/services/auth/bloc/auth_bloc.dart';
import 'package:flutterapp/data/services/auth/bloc/auth_event.dart';
import 'package:flutterapp/data/services/auth/bloc/auth_state.dart';
import 'package:flutterapp/data/services/auth/firebase_auth_provider.dart';
import 'package:flutterapp/ui/constants/view_selections.dart';
import 'package:flutterapp/ui/views/full_size_image.dart';
import 'package:flutterapp/ui/views/login.dart';
import 'package:flutterapp/ui/views/navbar/detail_view.dart';
import 'package:flutterapp/ui/views/navholder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const StartingPage(),
      ),
      routes: {
        detailRoute: (context) => const DetailView(
              view: detail,
            ),
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
          return NavHolder(
            user: state.user,
          );
        } else if (state is AuthStateLoggedOut ||
            state is AuthStateRegistering) {
          return const LoginView();
        } else {
          return const Scaffold();
        }
      },
    );
  }
}
