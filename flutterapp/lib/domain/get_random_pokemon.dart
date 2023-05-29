import '../data/services/repository.dart';
import 'models/filtered_pokemon_model.dart';

class GetRandomPokemon {
  final PokemonRepository _repository = PokemonRepository();

  Future<FilteredPokemonModel> getRandomPokemon() async {
    return await _repository.getRandomPokemonFromDatabase();
  }
}
