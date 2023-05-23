import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/services/auth/bloc/auth_state.dart';

import '../services/auth/auth_service.dart';
import '../services/auth/bloc/auth_bloc.dart';
import '../services/auth/bloc/auth_event.dart';
import '../services/auth/exceptions/auth_exceptions.dart';
import '../util/dialogs/error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          if (state.exception is UserNotFoundAuthException) {
            await showErrorDialog(context, "User not found");
          } else if (state.exception is WrongPasswordAuthException) {
            await showErrorDialog(context, "Wrong password");
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, "Authentication error");
          }
        }
        if (mounted) {
          if (state is AuthStateRegistering) {
            if (state.exception is WeakPasswordAuthException) {
              await showErrorDialog(context, "Weak password");
            } else if (state.exception is EmailAlreadyInUsedAuthException) {
              await showErrorDialog(context, "Email already in use");
            } else if (state.exception is InvalidEmailException) {
              showErrorDialog(context, "Invalid email");
            } else if (state.exception is GenericAuthException) {
              showErrorDialog(context, "Error");
            }
          }
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50.0,
              ),
              SizedBox(
                width: 300,
                height: 300,
                child: Image.asset("assets/render_rayquaza_mega.png"),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 350,
                height: 20,
                child: TextField(
                  controller: _email,
                  decoration: const InputDecoration(hintText: "Email"),
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 350,
                height: 20,
                child: TextField(
                  controller: _password,
                  decoration: const InputDecoration(hintText: "Password"),
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 355,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 79, 165, 235),
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: TextButton(
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;
                      context
                          .read<AuthBloc>()
                          .add(AuthEventLogIn(email, password));
                    },
                    child: const Text(
                        style: TextStyle(color: Colors.black), "LOGIN"),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: 355,
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 79, 165, 235)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16))),
                    child: TextButton(
                        onPressed: () async {
                          final email = _email.text;
                          final password = _password.text;

                          context
                              .read<AuthBloc>()
                              .add(AuthEventRegister(email, password));
                        },
                        child: const Text(
                            style: TextStyle(color: Colors.black),
                            "REGISTER"))),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 50,
                width: 355,
                child: Container(
                    color: const Color.fromARGB(255, 235, 231, 231),
                    child: TextButton(
                        onPressed: () async {},
                        child: Row(
                          children: [
                            Image.asset("assets/google.png"),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                                style: TextStyle(color: Colors.black),
                                "GOOGLE"),
                          ],
                        ))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
