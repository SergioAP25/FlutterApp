import '../data/services/repository.dart';
import 'models/filtered_pokemon_model.dart';

class GetPokemonsByName {
  final PokemonRepository _repository = PokemonRepository();

  Future<List<FilteredPokemonModel>> getPokemonsByName(String name) async {
    return await _repository.getPokemonByNameFromDatabase(name);
  }
}
