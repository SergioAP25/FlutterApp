import '../data/services/repository.dart';
import 'models/filtered_pokemon_model.dart';

class GetFavoritePokemonByNameFilteredByMultiType {
  final PokemonRepository _repository = PokemonRepository();

  Future<List<FilteredPokemonModel>>
      getFavoritePokemonByNameFilteredByMultiType(
          String name, String type1, String type2) async {
    return await _repository
        .getFavoritePokemonByNameFilteredByMultiTypeFromDatabase(
            name, type1, type2);
  }
}
