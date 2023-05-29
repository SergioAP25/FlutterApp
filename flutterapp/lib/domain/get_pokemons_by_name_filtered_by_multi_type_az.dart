import '../data/services/repository.dart';
import 'models/filtered_pokemon_model.dart';

class GetPokemonsByNameFilteredByMultiTypeAZ {
  final PokemonRepository _repository = PokemonRepository();

  Future<List<FilteredPokemonModel>> getPokemonsByNameFilteredByMultiTypeAZ(
      String name, String type1, String type2) async {
    return await _repository.getPokemonByNameFilteredByMultiTypeFromDatabaseAZ(
        name, type1, type2);
  }
}
