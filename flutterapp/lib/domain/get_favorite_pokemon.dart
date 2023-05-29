import 'package:flutterapp/domain/models/filtered_pokemon_model.dart';

import '../data/services/repository.dart';

class GetFavoritePokemon {
  final PokemonRepository _repository = PokemonRepository();

  Future<List<FilteredPokemonModel>> getFavoritePokemon(String name) async {
    return await _repository.getFavoritePokemonByNameFromDatabase(name);
  }
}
