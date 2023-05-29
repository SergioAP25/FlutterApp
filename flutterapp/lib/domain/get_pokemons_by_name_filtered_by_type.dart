import '../data/services/repository.dart';
import 'models/filtered_pokemon_model.dart';

class GetPokemonsByNameFilteredByType {
  final PokemonRepository _repository = PokemonRepository();

  Future<List<FilteredPokemonModel>> getPokemonsByNameFilteredByType(
      String name, String type) async {
    return await _repository.getPokemonByNameFilteredByTypeFromDatabase(
        name, type);
  }
}
