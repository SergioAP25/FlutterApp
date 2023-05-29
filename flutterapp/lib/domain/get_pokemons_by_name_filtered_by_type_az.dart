import '../data/services/repository.dart';
import 'models/filtered_pokemon_model.dart';

class GetPokemonsByNameFilteredByTypeAZ {
  final PokemonRepository _repository = PokemonRepository();

  Future<List<FilteredPokemonModel>> getPokemonsByNameFilteredByTypeAZ(
      String name, String type) async {
    return await _repository.getPokemonByNameFilteredByTypeFromDatabaseAZ(
        name, type);
  }
}
