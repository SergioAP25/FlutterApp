import '../data/services/repository.dart';
import 'models/filtered_pokemon_model.dart';

class GetPokemonsByNameFilteredByTypeZA {
  final PokemonRepository _repository = PokemonRepository();

  Future<List<FilteredPokemonModel>> getPokemonsByNameFilteredByTypeZA(
      String name, String type) async {
    return await _repository.getPokemonByNameFilteredByTypeFromDatabaseZA(
        name, type);
  }
}
