import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/auth/auth_service.dart';
import '../../services/auth/bloc/auth_bloc.dart';
import '../../services/auth/bloc/auth_event.dart';
import '../../util/dialogs/log_out_dialog.dart';

class Options extends StatelessWidget {
  const Options({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: 190,
          child: Column(
            children: [
              const Text(
                "Email:",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Text(
                "EMAILHOLDER",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Provider:",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Text(
                "PROVIDERHOLDER",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
