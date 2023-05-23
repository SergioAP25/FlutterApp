import 'package:flutter/material.dart';

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
                    onPressed: () async {},
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
