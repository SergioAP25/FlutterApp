import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterapp/services/api/api_service.dart';
import 'package:http/http.dart' as http;

class Pokedex extends StatefulWidget {
  const Pokedex({super.key});

  @override
  State<Pokedex> createState() => _PokedexState();
}

class _PokedexState extends State<Pokedex> {
  @override
  Widget build(BuildContext context) {
    ApiService().getAllPokemons();
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none),
                hintText: "Search Here",
                prefixIcon: const Icon(Icons.search),
                prefixIconColor: Colors.grey),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: ListView(), // Usar listView.builder
          )
        ],
      ),
    );
  }
}
