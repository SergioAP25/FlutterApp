import 'package:flutterapp/domain/models/description_pokemon_model.dart';
import 'package:flutterapp/domain/models/filtered_pokemon_model.dart';
import 'package:flutterapp/domain/models/pokemon_model.dart';
import 'package:flutterapp/services/api/api_service.dart';
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

  Future<FilteredPokemonModel> getPokemonByUrl(String endpoint) async {
    final result = await _api.getPokemonByUrl(endpoint);
    return FilteredPokemonModel.fromApi(result);
  }

  Future<DescriptionModel> getPokemonDescriptionByUrls(String endpoint) async {
    final result = await _api.getPokemonDescriptionByUrl(endpoint);
    return DescriptionModel.fromApi(result);
  }

  Future<void> insertPokemon(FilteredPokemonModel pokemon) async {
    await _database.insertPokemon(pokemon: pokemon);
  }

  Future<void> insertDescriptions(DescriptionModel description) async {
    await _database.insertDescription(description: description);
  }

  Future<void> insertFavorite(String name) async {
    await _database.insertFavorite(name: name);
  }

  Future<void> deleteFavorite(String name) async {
    await _database.deleteFavorite(name: name);
  }

  Future<int> countPokemons() async {
    return await _database.countPokemons();
  }

  Future<int> countDescriptions() async {
    return await _database.countDescriptions();
  }

  Future<bool> exists(String name) async {
    return await _database.exists(name);
  }

  Future<bool> isFavorite(String name) async {
    return await _database.isFavorite(name);
  }

  Future<List<FilteredPokemonModel>> getPokemonByNameFromDatabase(
      String name) async {
    final databaseResult = await _database.getPokemonByName(name: name);
    return databaseResult
        .map((e) => FilteredPokemonModel.fromDatabase(e))
        .toList();
  }

  Future<List<FilteredPokemonModel>> getPokemonByNameAZFromDatabase(
      String name) async {
    final databaseResult = await _database.getPokemonByNameAZ(name: name);
    return databaseResult
        .map((e) => FilteredPokemonModel.fromDatabase(e))
        .toList();
  }

  Future<List<FilteredPokemonModel>> getPokemonByNameZAFromDatabase(
      String name) async {
    final databaseResult = await _database.getPokemonByNameZA(name: name);
    return databaseResult
        .map((e) => FilteredPokemonModel.fromDatabase(e))
        .toList();
  }

  Future<List<FilteredPokemonModel>> getPokemonByNameFilteredByTypeFromDatabase(
      String name, String type) async {
    final databaseResult =
        await _database.getPokemonByNameFilteredByType(name: name, type: type);
    return databaseResult
        .map((e) => FilteredPokemonModel.fromDatabase(e))
        .toList();
  }

  Future<List<FilteredPokemonModel>>
      getPokemonByNameFilteredByMultiTypeFromDatabase(
          String name, String type1, String type2) async {
    final databaseResult = await _database.getPokemonByNameFilteredByMultiType(
        name: name, type1: type1, type2: type2);
    return databaseResult
        .map((e) => FilteredPokemonModel.fromDatabase(e))
        .toList();
  }

  Future<List<FilteredPokemonModel>>
      getPokemonByNameFilteredByTypeFromDatabaseAZ(
          String name, String type) async {
    final databaseResult = await _database.getPokemonByNameFilteredByTypeAZ(
        name: name, type: type);
    return databaseResult
        .map((e) => FilteredPokemonModel.fromDatabase(e))
        .toList();
  }

  Future<List<FilteredPokemonModel>>
      getPokemonByNameFilteredByTypeFromDatabaseZA(
          String name, String type) async {
    final databaseResult = await _database.getPokemonByNameFilteredByTypeZA(
        name: name, type: type);
    return databaseResult
        .map((e) => FilteredPokemonModel.fromDatabase(e))
        .toList();
  }

  Future<List<FilteredPokemonModel>>
      getPokemonByNameFilteredByMultiTypeFromDatabaseAZ(
          String name, String type1, String type2) async {
    final databaseResult =
        await _database.getPokemonByNameFilteredByMultiTypeAZ(
            name: name, type1: type1, type2: type2);
    return databaseResult
        .map((e) => FilteredPokemonModel.fromDatabase(e))
        .toList();
  }

  Future<List<FilteredPokemonModel>>
      getPokemonByNameFilteredByMultiTypeFromDatabaseZA(
          String name, String type1, String type2) async {
    final databaseResult =
        await _database.getPokemonByNameFilteredByMultiTypeZA(
            name: name, type1: type1, type2: type2);
    return databaseResult
        .map((e) => FilteredPokemonModel.fromDatabase(e))
        .toList();
  }

  Future<List<FilteredPokemonModel>> getFavoritePokemonByNameFromDatabase(
      String name) async {
    final databaseResult = await _database.getFavoritePokemonByName(name: name);
    return databaseResult
        .map((e) => FilteredPokemonModel.fromDatabase(e))
        .toList();
  }

  Future<FilteredPokemonModel> getRandomPokemonFromDatabase() async {
    final databaseResult = await _database.getRandomPokemon();
    return FilteredPokemonModel.fromDatabase(databaseResult);
  }
}
