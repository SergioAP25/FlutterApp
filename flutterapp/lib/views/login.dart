import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 30.0,
            ),
            SizedBox(
              width: 300,
              height: 300,
              child: Image.network(
                  "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/695f7949-df76-4452-bdf0-130afea52f21/dc74mzh-9f3e26a3-e112-4b37-8420-83e533bd684a.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzY5NWY3OTQ5LWRmNzYtNDQ1Mi1iZGYwLTEzMGFmZWE1MmYyMVwvZGM3NG16aC05ZjNlMjZhMy1lMTEyLTRiMzctODQyMC04M2U1MzNiZDY4NGEucG5nIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.jUbPgF21IgD-Lxpo0OfJzjlFWWXris4XTEqtGx-XkhE"),
            ),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
              width: 350,
              height: 20,
              child: TextField(
                decoration: InputDecoration(hintText: "Enter your email"),
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
              width: 350,
              height: 20,
              child: TextField(
                decoration: InputDecoration(hintText: "Enter your password"),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
              ),
            ),
            TextButton(
              onPressed: () async {},
              child: const Text("Login"),
            ),
            TextButton(onPressed: () {}, child: const Text("Register"))
          ],
        ),
      ),
    );
  }
}
