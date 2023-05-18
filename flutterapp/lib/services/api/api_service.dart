import 'dart:convert';
import 'package:flutterapp/services/api/models/api_description_model.dart';
import 'package:flutterapp/services/api/models/api_filtered_pokemon.dart';
import 'package:flutterapp/services/api/models/api_pokemon_model.dart';
import 'package:http/http.dart' as http;
import 'constants/api_constants.dart';

class ApiService {
  static final ApiService _apiService = ApiService._sharedInstance();

  factory ApiService() {
    return _apiService;
  }

  ApiService._sharedInstance();

  Future<PokemonApiModel> getAllPokemons() async {
    const endpoint = base_url + allPokemons;
    final uri = Uri.parse(endpoint);
    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    return PokemonApiModel.fromJson(json);
  }

  Future<FilteredPokemonApiModel> getPokemonByUrl(String endpoint) async {
    final uri = Uri.parse(endpoint);
    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    return FilteredPokemonApiModel.fromJson(json);
  }

  Future<DescriptionApiModel> getPokemonDescriptionByUrl(
      String endpoint) async {
    final uri = Uri.parse(endpoint);
    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    return DescriptionApiModel.fromJson(json);
  }
}
