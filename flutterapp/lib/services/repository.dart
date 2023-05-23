import 'package:flutterapp/domain/models/description_pokemon_model.dart';
import 'package:flutterapp/domain/models/filtered_pokemon_model.dart';
import 'package:flutterapp/domain/models/pokemon_model.dart';
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

  Future<PokemonModel> getAllPokemons() async {
    final result = await _api.getAllPokemons();
    return PokemonModel.fromApi(result);
  }

  Future<FilteredPokemonModel> getPokemonByUrl(String? endpoint) async {
    final result = await _api.getPokemonByUrl(endpoint);
    return FilteredPokemonModel.fromApi(result);
  }

  Future<DescriptionModel> getPokemonDescriptionByUrls(String endpoint) async {
    final result = await _api.getPokemonDescriptionByUrl(endpoint);
    return DescriptionModel.fromApi(result);
  }

  Future<List<FilteredPokemonModel>> getPokemonByNameFromDatabase(
      String name) async {
    final databaseResult = await _database.getPokemonByName(name: name);
    return databaseResult
        .map((e) => FilteredPokemonModel.fromDatabase(e))
        .toList();
  }

  Future<void> insertPokemon(FilteredPokemonModel pokemon) async {
    await _database.insertPokemon(pokemon: pokemon);
  }
}
