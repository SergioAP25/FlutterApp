import '../data/services/repository.dart';
import 'models/filtered_pokemon_model.dart';

class GetPokemonsByNameFilteredByMultiType {
  final PokemonRepository _repository = PokemonRepository();

  Future<List<FilteredPokemonModel>> getPokemonsByNameFilteredByMultiType(
      String name, String type1, String type2) async {
    return await _repository.getPokemonByNameFilteredByMultiTypeFromDatabase(
        name, type1, type2);
  }
}
