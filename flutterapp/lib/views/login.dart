import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const SizedBox(
              width: 350,
              height: 20,
              child: TextField(
                decoration: InputDecoration(hintText: "Email"),
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
                decoration: InputDecoration(hintText: "Password"),
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
                  onPressed: () async {},
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
                      onPressed: () {},
                      child: const Text(
                          style: TextStyle(color: Colors.black), "REGISTER"))),
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
                      onPressed: () {},
                      child: Row(
                        children: [
                          Image.asset("assets/google.png"),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                              style: TextStyle(color: Colors.black), "GOOGLE"),
                        ],
                      ))),
            )
          ],
        ),
      ),
    );
  }
}
