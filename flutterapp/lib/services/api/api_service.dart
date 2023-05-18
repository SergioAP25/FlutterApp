import 'dart:convert';

import 'package:flutterapp/services/api/models/api_pokemon_model.dart';
import 'package:http/http.dart' as http;

const base_url = "https://pokeapi.co/api/v2/";
const allPokemons = "pokemon";

class ApiService {
  Future<PokemonApiModel> getAllPokemons() async {
    const endpoint = base_url + allPokemons;
    final uri = Uri.parse(endpoint);
    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    return PokemonApiModel.fromJson(json);
  }
}
