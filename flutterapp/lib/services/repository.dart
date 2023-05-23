import 'package:flutterapp/domain/models/filtered_pokemon_model.dart';
import 'package:flutterapp/services/api/api_service.dart';
import 'package:flutterapp/services/api/models/api_description_model.dart';
import 'package:flutterapp/services/api/models/api_filtered_pokemon.dart';
import 'package:flutterapp/services/api/models/api_pokemon_model.dart';
import 'package:flutterapp/services/database/database_service.dart';

class PokemonRepository {
  final ApiService _api = ApiService();
  final PokemonService _database = PokemonService();

  static final PokemonRepository _pokemonRepository =
      PokemonRepository._sharedInstance();

  factory PokemonRepository() {
    return _pokemonRepository;
  }

  PokemonRepository._sharedInstance();

  Future<PokemonApiModel> getAllPokemons() async {
    final result = await _api.getAllPokemons();
    return result;
  }

  Future<FilteredPokemonApiModel> getPokemonByUrl(String? endpoint) async {
    final result = await _api.getPokemonByUrl(endpoint);
    return result;
  }

  Future<DescriptionApiModel> getPokemonDescriptionByUrls(
      String endpoint) async {
    final result = await _api.getPokemonDescriptionByUrl(endpoint);
    return result;
  }

  Future<void> insertPokemon(FilteredPokemonApiModel pokemon) async {
    await _database.insertPokemon(pokemon: pokemon);
  }

  Future<List<FilteredPokemonModel>> getPokemonByNameFromDatabase(
      String name) async {
    final databaseResult = await _database.getPokemonByName(name: name);
    return databaseResult
        .map((e) => FilteredPokemonModel.fromDatabase(e))
        .toList();
  }
}
