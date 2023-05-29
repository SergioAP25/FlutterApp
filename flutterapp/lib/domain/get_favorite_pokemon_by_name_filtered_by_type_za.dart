import '../data/services/repository.dart';
import 'models/filtered_pokemon_model.dart';

class GetFavoritePokemonByNameFilteredByTypeZA {
  final PokemonRepository _repository = PokemonRepository();

  Future<List<FilteredPokemonModel>> getFavoritePokemonByNameFilteredByTypeZA(
      String name, String type) async {
    return await _repository
        .getFavoritePokemonByNameFilteredByTypeFromDatabaseZA(name, type);
  }
}
