import '../data/services/repository.dart';
import 'models/filtered_pokemon_model.dart';

class GetFavoritePokemonByNameFilteredByMultiTypeAZ {
  final PokemonRepository _repository = PokemonRepository();

  Future<List<FilteredPokemonModel>>
      getFavoritePokemonByNameFilteredByMultiTypeAZ(
          String name, String type1, String type2) async {
    return await _repository
        .getFavoritePokemonByNameFilteredByMultiTypeFromDatabaseAZ(
            name, type1, type2);
  }
}
