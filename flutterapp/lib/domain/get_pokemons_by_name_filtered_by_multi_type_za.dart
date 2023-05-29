import '../data/services/repository.dart';
import 'models/filtered_pokemon_model.dart';

class GetPokemonsByNameFilteredByMultiTypeZA {
  final PokemonRepository _repository = PokemonRepository();

  Future<List<FilteredPokemonModel>> getPokemonsByNameFilteredByMultiTypeZA(
      String name, String type1, String type2) async {
    return await _repository.getPokemonByNameFilteredByMultiTypeFromDatabaseZA(
        name, type1, type2);
  }
}
