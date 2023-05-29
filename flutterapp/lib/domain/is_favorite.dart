import '../data/services/repository.dart';
import 'models/filtered_pokemon_model.dart';

class IsFavorite {
  final PokemonRepository _repository = PokemonRepository();

  Future<bool> isFavorite(String name, String type1, String type2) async {
    return await _repository.isFavorite(name);
  }
}
