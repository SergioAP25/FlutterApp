import '../data/services/repository.dart';
import 'models/filtered_pokemon_model.dart';

class GetPokemonsByNameZA {
  final PokemonRepository _repository = PokemonRepository();

  Future<List<FilteredPokemonModel>> getPokemonsByNameZA(String name) async {
    return await _repository.getPokemonByNameZAFromDatabase(name);
  }
}
