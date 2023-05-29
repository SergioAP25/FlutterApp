import '../data/services/repository.dart';
import 'models/filtered_pokemon_model.dart';

class GetFavoritePokemonByNameFilteredByType {
  final PokemonRepository _repository = PokemonRepository();

  Future<List<FilteredPokemonModel>> getFavoritePokemonByNameFilteredByType(
      String name, String type) async {
    return await _repository.getFavoritePokemonByNameFilteredByTypeFromDatabase(
        name, type);
  }
}
