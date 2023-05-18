import 'package:flutterapp/services/api/api_service.dart';
import 'package:flutterapp/services/api/models/api_description_model.dart';
import 'package:flutterapp/services/api/models/api_filtered_pokemon.dart';
import 'package:flutterapp/services/api/models/api_pokemon_model.dart';

class PokemonRepository {
  final ApiService _api = ApiService();

  static final PokemonRepository _apiService =
      PokemonRepository._sharedInstance();

  factory PokemonRepository() {
    return _apiService;
  }

  PokemonRepository._sharedInstance();

  Future<PokemonApiModel> getAllPokemons() async {
    final result = await _api.getAllPokemons();
    return result;
  }

  Future<FilteredPokemonApiModel> getPokemonByUrl(String endpoint) async {
    final result = await _api.getPokemonByUrl(endpoint);
    return result;
  }

  Future<DescriptionApiModel> getPokemonDescriptionByUrls(
      String endpoint) async {
    final result = await _api.getPokemonDescriptionByUrl(endpoint);
    return result;
  }
}
