import '../data/services/repository.dart';
import 'models/filtered_pokemon_model.dart';

class GetFavoritePokemonByNameFilteredByTypeAZ {
  final PokemonRepository _repository = PokemonRepository();

  Future<List<FilteredPokemonModel>> getFavoritePokemonByNameFilteredByTypeAZ(String name, String type) async {
    return await _repository.getFavoritePokemonByNameFilteredByTypeFromDatabaseAZ(name, type);
  }
}