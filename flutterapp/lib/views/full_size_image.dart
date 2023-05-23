import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutterapp/util/generics/get_arguments.dart';

import '../services/api/models/api_filtered_pokemon.dart';

class FullSizeImageWindow extends StatelessWidget {
  const FullSizeImageWindow({super.key});

  @override
  Widget build(BuildContext context) {
    final image = context.getArgument<String>();
    return Scaffold(body: Center(child: Image.network(image!)));
  }
}
