import '../data/services/repository.dart';
import 'models/filtered_pokemon_model.dart';

class GetPokemonsByNameAZ {
  final PokemonRepository _repository = PokemonRepository();

  Future<List<FilteredPokemonModel>> getPokemonsByNameAZ(String name) async {
    return await _repository.getPokemonByNameAZFromDatabase(name);
  }
}
