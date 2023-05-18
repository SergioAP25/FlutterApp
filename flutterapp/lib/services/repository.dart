import 'package:flutterapp/services/api/api_service.dart';
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
    return PokemonApiModel.fromJson(result);
  }

  Future<FilteredPokemonApiModel> getPokemonByUrl(String endpoint) async {
    final result = await _api.getPokemonByUrl(endpoint);
    return FilteredPokemonApiModel.fromJson(result);
  }

  Future<PokemonApiModel> getPokemonDescriptionByUrls(String endpoint) async {
    final result = await _api.getPokemonDescriptionByUrl(endpoint);
    return PokemonApiModel.fromJson(result);
  }
}
