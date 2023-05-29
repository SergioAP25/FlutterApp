import '../data/services/repository.dart';
import 'models/filtered_pokemon_model.dart';

class GetFavoritePokemonByNameFilteredByMultiTypeZA {
  final PokemonRepository _repository = PokemonRepository();

  Future<List<FilteredPokemonModel>>
      getFavoritePokemonByNameFilteredByMultiTypeZA(
          String name, String type1, String type2) async {
    return await _repository
        .getFavoritePokemonByNameFilteredByMultiTypeFromDatabaseZA(
            name, type1, type2);
  }
}
