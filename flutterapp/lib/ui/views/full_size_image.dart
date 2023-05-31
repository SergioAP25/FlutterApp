import 'package:flutter/material.dart';
import 'package:flutterapp/util/generics/get_arguments.dart';

class FullSizeImageWindow extends StatelessWidget {
  const FullSizeImageWindow({super.key});

  @override
  Widget build(BuildContext context) {
    final image = context.getArgument<String>();
    return Scaffold(
      body: Center(
        child: Image.network(
          image!,
          fit: BoxFit.fitWidth,
          height: double.infinity,
          width: double.infinity,
        ),
      ),
    );
  }
}
