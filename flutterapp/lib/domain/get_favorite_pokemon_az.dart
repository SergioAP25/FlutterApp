import '../data/services/repository.dart';
import 'models/filtered_pokemon_model.dart';

class GetFavoritePokemonAZ {
  final PokemonRepository _repository = PokemonRepository();

  Future<List<FilteredPokemonModel>> getFavoritePokemonAZ(String name) async {
    return await _repository.getFavoritePokemonByNameAZFromDatabase(name);
  }
}
