import '../data/services/repository.dart';
import 'models/filtered_pokemon_model.dart';

class GetFavoritePokemonZA {
  final PokemonRepository _repository = PokemonRepository();

  Future<List<FilteredPokemonModel>> getFavoritePokemonZA(String name) async {
    return await _repository.getFavoritePokemonByNameZAFromDatabase(name);
  }
}
