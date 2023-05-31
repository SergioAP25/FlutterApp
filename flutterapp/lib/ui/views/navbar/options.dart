import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/services/auth/auth_service.dart';
import '../../../data/services/auth/auth_user.dart';
import '../../../data/services/auth/bloc/auth_bloc.dart';
import '../../../data/services/auth/bloc/auth_event.dart';

class Options extends StatelessWidget {
  final AuthUser user;
  const Options({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: 220,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Email:",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                user.email!,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Provider:",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                user.provider!,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 355,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 79, 165, 235),
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: TextButton(
                    onPressed: () async {
                      await AuthService.firebase().logOut();
                      if (context.mounted) {
                        context.read<AuthBloc>().add(const AuthEventLogout());
                      }
                    },
                    child: const Text(
                        style: TextStyle(color: Colors.black), "LOG OUT"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
